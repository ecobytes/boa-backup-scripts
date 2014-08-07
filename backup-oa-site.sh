#!/bin/bash
# Usage: backup-oa-site.sh $backup_path $fqdn_site_name $user_at_server_name 

# Init variables
backup_path=$1
fqdn_site_name=$2
user_at_server_name=$3

# Start backup
#/usr/bin/drush @$fqdn_site_name provision-backup --backend

site_name=`echo $fqdn_site_name | cut -f 1 -d.`
site_backup_path="$backup_path$site_name"

# Move backups
mv $backup_path$fqdn_site_name* $site_backup_path

# Rotate backups
ls -1 $site_backup_path | sort -r | tail -n +6 | xargs rm

# Rsync backups
rsync -vuL -e ssh $site_backup_path $user_at_server_name:~/$site_name