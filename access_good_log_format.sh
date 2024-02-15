#!/bin/bash

#server IP addresses
SERVERS=("192.168.50.11" "192.168.50.12" "192.168.50.13")

# Read passwords from the password.txt file
PASSWORD_FILE="password.txt"

# Check if the password file exists
if [ ! -f "$PASSWORD_FILE" ]; then
    echo "Error: Password file not found: $PASSWORD_FILE" >&2
    exit 1
fi

# Read passwords from the file into an array
IFS=$'\n' read -d '' -r -a PASSWORDS < "$PASSWORD_FILE"

# Check if the number of passwords matches the number of servers
if [ "${#PASSWORDS[@]}" -ne "${#SERVERS[@]}" ]; then
    echo "Error: Number of passwords does not match the number of servers" >&2
    exit 1
fi

# Initialize log file
LOG_FILE="ssh_log.txt"
#echo -e "Server IP\tDate\tTime\tStatus" > "$LOG_FILE"

# Loop through each server
for ((i = 0; i < ${#SERVERS[@]}; i++)); do
    SERVER_IP="${SERVERS[$i]}"
    PASSWORD="${PASSWORDS[$i]}"

    # SSH into the server and perform some action (e.g., create a file)
    if sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 vagrant@"$SERVER_IP" "touch \$HOME/kennethFile_${SERVER_IP}_$(date +%Y%m%d_%s).txt"; then
        STATUS="Success"
    else
        STATUS="Failed"
    fi

    # Format date and time
    DATE=$(date "+%Y-%m-%d")
    TIME=$(date "+%H:%M:%S")

    # Append log entry to log file
#    echo -e "$SERVER_IP\t$DATE\t$TIME\t$STATUS" >> "$LOG_FILE"
     echo -e "$SERVER_IP\t$DATE\t$TIME\t$STATUS" | tee -a "$LOG_FILE"


done

# Format log file as a table
awk -F'\t' 'BEGIN { printf "%-15s %-10s %-8s %s\n", "Server IP", "Date", "Time", "Status" }
             { printf "%-15s %-10s %-8s %s\n", $1, $2, $3, $4 }' "$LOG_FILE" | column -t -s $'\t'






# Trigger access_good_log_formate.sh to run after my.sh
bash ./backup.sh

