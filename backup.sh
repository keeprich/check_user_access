#!/bin/bash

# Define variables
LOG_FILE="ssh_log.txt"
BACKUP_FILE="ssh_log_backup.txt"

# Check if ssh_log.txt exists and create a backup if it does
if [ -f "$LOG_FILE" ]; then
    cp "$LOG_FILE" "$BACKUP_FILE"
fi

# Your existing code to append data to ssh_log.txt
echo -e "$SERVER_IP\t$DATE\t$TIME\t$STATUS" >> "$LOG_FILE"

