#! /bin/bash

DATE=$(date +"%F")
BACKUP_DIR="/opt/backup/DAILY-MYSQL"
MYSQL_USER="root"
MYSQL=/usr/bin/mysql
MYSQL_PASSWORD=""
MYSQLDUMP=/usr/bin/mysqldump



databases=`$MYSQL --host=127.0.0.1 --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
 $MYSQLDUMP  --host=127.0.0.1 --opt --routines --triggers --events --skip-lock-tables --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > $BACKUP_DIR/"$db.`date +%m%d%Y%H%M%S`.gz"
done
 chmod -R 777 $BACKUP_DIR