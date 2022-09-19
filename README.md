A tool to backup Colorfront project databases.  Not affiliated with Colorfront.

[![main](https://github.com/llamafilm/cf_backup/actions/workflows/main.yml/badge.svg)](https://github.com/llamafilm/cf_backup/actions/workflows/main.yml)

### What it does
1. Query the SQL database to find out which projects have been udpated since the last backup
2. Dump those schemas with `mysqldump`
3. Copy the SQL dump along with the project's PHP scripts into a compressed tarball and label it by date.

### Installation
Optional: Build a binary with PyInstaller to make Python interpreter self-contained.

```
pyinstaller cf_backup.spec
```

If you cloned the git repo, the binary will be generated with git commit number.  Rename it to simply `cf_backup` and copy to a reasonable location such as `/usr/local/bin`.
Assuming you are running on linux, add a cron job like this:

```
0 23 * * 1-5 /usr/local/bin/cf_backup /mnt/path/to/your/archive | logger -t cf_backup
```

This will schedule it for 11pm every weekday and pipe the logs to syslog.  You can view the logs later with `journalctl -t cf_backup`.

Advanced option: If your SQL database is running on a different host than this code, configure options in `~/.my.cnf` e.g.
```
[client]
protocol=tcp
host=
user=
pass=
```

### Usage
Documentation is self-contained with the `-help` option:
```
usage: cf_backup.py [-h] [--version] [--webroot WEBROOT] [--mysqldump MYSQLDUMP] [--mysql MYSQL] [--verbose] output

Backup Colorfront projects which have changed since last time.  MySQL and PHP scripts will be archived to a compressed tarball. Example usage piped to CentOS syslog: 
        ./cf_backup /mnt/archive/colorfront/ | logger -t cf_backup

positional arguments:
  output                directory to save the backups

optional arguments:
  -h, --help            show this help message and exit
  --version             prints application version
  --webroot WEBROOT, -w WEBROOT
                        location of Apache webroot directory (htdocs)
  --mysqldump MYSQLDUMP, -d MYSQLDUMP
                        path to mysqldump binary; search PATH if not provided
  --mysql MYSQL, -m MYSQL
                        path to mysql binary; search PATH if not provided
  --verbose, -v         print extra debugging info
```

### Requirements
- MySQL 5.7 or similar version (MariaDB 10.3, etc) binaries available in PATH
- Python 3.5+
- Read access to Apache webroot. e.g. `/var/www/html`
- Regular database schema from Colorfront OSD/ExD
