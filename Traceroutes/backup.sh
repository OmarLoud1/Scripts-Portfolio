#!/bin/bash

backup_source="."
backup_dest="./back"
timestamp_file="$backup_dest/last_backup_timestamp"

mkdir -p "$backup_dest"
last_backup=$(cat "$timestamp_file" 2>/dev/null || echo "1970-01-01")
backup_filename="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

find "$backup_source" -type f -newermt "$last_backup" -print0 | tar -czvf "$backup_dest/$backup_filename" --null -T -
date "+%Y-%m-%d %H:%M:%S" > "$timestamp_file"

echo "Backup created: $backup_filename"
echo "Backup directory: $backup_dest"
