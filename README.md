A tool to backup Colorfront project databases.  Not affiliated with Colorfront.

### What it does
1. Query the SQL database to find out which projects have been udpated since the last backup
2. Dump those schemas with `mysqldump`
3. Copy the SQL dump along with htdocs into a compressed tarball and label it by date.

### Installation
Optional: Build a binary with PyInstaller to make Python interpreter self-contained.

```
pyinstaller cf_backup.spec
```

The binary will be generated with git commit number.  Rename it to simply `cf_backup` and copy to a reasonable location such as `/usr/local/bin`.
Add a cron job like this:

```
0 23 * * 1-5 /usr/local/bin/cf_backup /mnt/path/to/your/archive | logger -t cf_backup
```

This will schedule it for 11pm every weekday and pipe the logs to syslog.  You can view the logs later with journalctl -t cf_backup.

If you need to talk to a remote database, configure options in `~/.my.cnf` e.g.
```
protocol=tcp
host=1.2.3.4
user=root
pass=password
```

### Requirements
MySQL 5.7 or similar version (MariaDB 10.3, etc) binaries available in PATH
Python 3.5+
Read access to Apache webroot. e.g. `/var/www/html`
