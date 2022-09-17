#!/bin/env python3

"""Backup Colorfront SQL database and htdocs from local machine.
Pipe to CentOS syslog example: cf_backup /mnt/archive/colorfront | logger -t cf_backup
To read these logs: journalctl -t cf_backup -o cat
"""

import sys
import io
import tarfile
import time
import subprocess
import argparse
from pathlib import Path
from datetime import datetime
import _version


def do_backup(args, project, proj_dir):
    if args.verbose:
        print("\nDEBUG:", project, proj_dir)
        tardebug = 3
    else:
        tardebug = 0

    now = time.strftime(args.datefmt)
    filename = proj_dir / (project['Name'] + '_' + now + '.tar.gz')

    # make sure we can see htdocs
    if not (args.webroot / project['Name']).is_dir():
        print("ERROR: Couldn't find scripts:", args.webroot / project['Name'])
        return False
    
    # dump SQL as bytes to avoid charset issues
    try:
        dump = subprocess.run([args.mysqldump, '-h', '127.0.0.1', '-ufugu', '-pfugu', project['Name']], stdout=subprocess.PIPE, check=True)
    except subprocess.CalledProcessError:
        print('ERROR: Failed to dump SQL')
        return False

    with tarfile.open(filename, 'w:gz', compresslevel=6, debug=tardebug) as tar:
        # add scripts folder with htdocs/ prefix
        tar.add(args.webroot / project['Name'], arcname='htdocs/' + project['Name'])

        # add SQL dump with current timestamp
        info = tarfile.TarInfo(name=project['Name'] + '_' + now + '.sql')
        info.size =len(dump.stdout)
        info.mtime = time.time()
        #info.uname = info.gname = '_mysql'
        tar.addfile(info, io.BytesIO(dump.stdout))
    
    return True


def draw_table(need_backup):
    print(f"Backing up {len(need_backup)} projects which have changed since last backup.")
    print('','-'*40, '-'*17, '-'*16, '-'*16, '-'*9, '', sep='+')
    print("| {:38s} | {:15s} | {:14s} | {:14s} | {:7s} |".format(
        'Project Name', 'Version', 'Last Updated', 'Last Backup', 'Size MB'), sep='')
    print('','='*40, '='*17, '='*16, '='*16, '='*9, '', sep='+')
    for project in need_backup:
        if project['last_backup']:
            project['last_backup'] = project['last_backup'].strftime('%x %H:%M')
        else:
            project['last_backup'] = 'never'
        print("| {:38s} | {:15s} | {:14s} | {:14s} | {:7.1f} |".format(
            project['Name'], project['ProjectVersion'], project['mod_time'].strftime('%x %H:%M'), project['last_backup'], project['size_MB']), sep='')
    print('','-'*40, '-'*17, '-'*16, '-'*16, '-'*9, '', sep='+')


def parse_args():
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter,
        description="""Backup Colorfront projects which have changed since last time.  MySQL and PHP scripts will be archived to a compressed tarball. Example usage piped to CentOS syslog: 
        ./cf_backup /mnt/archive/colorfront/ | logger -t cf_backup""",
        epilog="© 2020 Elliott Balsley.  All rights reserved.")
    parser.add_argument('output', help='directory to save the backups')
    parser.add_argument('--version', help='prints application version', action='version', version='%(prog)s version ' + _version.version)
    parser.add_argument('--webroot', '-w', help='location of Apache webroot directory (htdocs)', default='/var/www/html')
    parser.add_argument('--mysqldump', '-d', help='path to mysqldump binary; search PATH if not provided', default='mysqldump')
    parser.add_argument('--mysql', '-m', help='path to mysql binary; search PATH if not provided', default='mysql')
    # parser.add_argument('--datefmt', '-f', help='date format used for archive filenames, default %%Y%%m%%d-%%H%%M%%S', default='%Y%m%d-%H%M%S')
    parser.add_argument('--verbose', '-v', help='print extra debugging info', action='store_true')

    args = parser.parse_args()
    args.datefmt = '%Y%m%d-%H%M%S'

    # get absolute path, remove home tilde and symlinks
    args.output = Path(args.output).expanduser().resolve()
    args.webroot = Path(args.webroot).expanduser().resolve()
    if args.verbose:
        print("DEBUG:", args)
    return args


def query(bin_path, sql):
    """Return list of dicts for a given SQL query.  Query must be in batch format with tab-separated headers"""
    result = []
    try:
        proc = subprocess.run([bin_path, '-ufugu', '-pfugu', '--batch', '-e', sql], 
            stdout=subprocess.PIPE, check=True, universal_newlines=True)
    except subprocess.CalledProcessError:
        print('ERROR! mysql query failed:', sql)
        return False

    lines = proc.stdout.splitlines()
    if not lines:
        print(f"Error!  SQL query returned empty result: '{sql}'")
        return False
        
    headers = lines.pop(0)
    num_cols = len(headers.split('\t'))
    for line in lines:
        row = {}
        for i in range(num_cols):
            row[headers.split('\t')[i]] = line.split('\t')[i]
        result.append(row)

    return result


def main():
    start = time.time()
    errors = []
    need_backup = []
    args = parse_args()

    # summary info for debugging
    if args.verbose:
        print('Running in Python', sys.version)
    print(time.strftime('%c'))
    print(f"Backing up Colorfront projects to {args.output}.")
    
    # make sure the binaries work
    for binary in [args.mysql, args.mysqldump]:
        try:
            print(subprocess.check_output([binary, '--version'], universal_newlines=True).rstrip())
        except subprocess.CalledProcessError:
            # mysqldump prints its own warnings
            sys.exit(1)
        except FileNotFoundError:
            print(f"ERROR: Could not find {binary}.")
            sys.exit(1)

    # validate webroot
    if not args.webroot.is_dir():
        print(f"ERROR: {args.webroot} is not a valid directory.  Specify webroot with -w argument.")
        sys.exit(1)

    # make folder if it doesn't exist
    try:
        args.output.mkdir(parents=True, exist_ok=True)
    except PermissionError:
        print(f"Permission denied: Unable to create directory at {args.output}")
        sys.exit()

    # get projects list
    sql = 'SELECT Name, ProjectVersion FROM projects.projects'
    proj_list = query(args.mysql, sql) or sys.exit(1)

    # get last modification time and size for each project
    sql = 'SELECT table_schema, ROUND(SUM(data_length + index_length)/1024/1024, 1) AS size_MB, DATE_FORMAT(MAX(update_time), "%Y-%m-%d %H:%i:%S") AS mod_time FROM information_schema.tables GROUP BY table_schema'
    info = query(args.mysql, sql) or sys.exit(1)
    
    # add size and mod time to project list
    for idx, proj in enumerate(proj_list):
        for row in info:
            # This might fail on case-sensitive linux database
            if proj['Name'].lower() == row['table_schema'].lower():
                # convert time string to datetime object
                # ignore schema by setting to ancient date if missing update_time
                try:
                    proj_list[idx]['mod_time'] = datetime.strptime(row['mod_time'], "%Y-%m-%d %H:%M:%S")
                except ValueError:
                    proj_list[idx]['mod_time'] = datetime(1999,12,31)

                try:
                    proj_list[idx]['size_MB'] = float(row['size_MB'])
                except ValueError:
                    proj_list[idx]['size_MB'] = 0.0
        
        # compare projects table with information_schema to see what has changed
        proj_dir = args.output / proj['Name']
        proj_dir.mkdir(parents=True, exist_ok=True)
        # check latest backup time, if any.
        if any(proj_dir.iterdir()):
            date_len = len(time.strftime(args.datefmt))
            latestfile = max(proj_dir.iterdir()).name
            try:
                proj['last_backup'] = datetime.strptime(latestfile[-7-date_len:-7], args.datefmt)
            except ValueError:
                print(f"WARNING: Found extra files in {proj['Name']} backup directory: {latestfile}.  Marking for backup.")
                proj['last_backup'] = False
        else:
            proj['last_backup'] = False
        
        # this happens if the schema doesn't exist although it's listed in project table
        if 'mod_time' not in proj:
            print(f"ERROR: {proj['Name']} was not found in information_schema.")
        else:
            # backup if changed since last backup, or never backed up
            if (not proj['last_backup'] or proj['mod_time'] > proj['last_backup']):
                need_backup.append(proj)

    if need_backup:
        need_backup = sorted(need_backup, key=lambda k: k['mod_time'], reverse=True)
        draw_table(need_backup)

        for idx, proj in enumerate(need_backup):
            proj_dir = args.output / proj['Name']
            print('Backing up {} ({} of {})'.format(proj['Name'], idx + 1, len(need_backup)), '... ', end='')
            if not do_backup(args, proj, proj_dir):
                errors.append(proj['Name'])
            else:
                print('OK')
        print('Finished after {:.0f} seconds.'.format(time.time() - start))

        if errors:
            if len(errors) > 1:
                print(f"There were {len(errors)} errors!")
            else:
                print(f"There was 1 error!")
            sys.exit(1)
        
    else:
        print('Nothing to backup.')


if __name__ == "__main__":
    main()
    print('\n') # need a line break when redirecting stdout to logfile
