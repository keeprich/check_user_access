#!/bin/bash

# Check if sshpass is installed, if not, install it
if ! command -v sshpass &> /dev/null; then
    echo "sshpass is not installed, installing it..."
    sudo yum install -y sshpass  # For CentOS/RHEL
    #sudo apt-get install -y sshpass  # For Ubuntu/Debian
fi

# Server IP addresses
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

# Loop through each server
for ((i = 0; i < ${#SERVERS[@]}; i++)); do
    SERVER_IP="${SERVERS[$i]}"
    PASSWORD="${PASSWORDS[$i]}"

    # SSH into the server and perform some action (e.g., list files)
    if sshpass -p "$PASSWORD" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=5 vagrant@"$SERVER_IP" "ls"; then
        STATUS="Success"
    else
        STATUS="Failed"
    fi

    # Format date and time
    DATE=$(date "+%Y-%m-%d")
    TIME=$(date "+%H:%M:%S")

    # Append log entry to log file
    echo -e "$SERVER_IP\t$DATE\t$TIME\t$STATUS" >> "$LOG_FILE"
done

# Format log file as a table
awk -F'\t' 'BEGIN { printf "%-15s %-10s %-8s %s\n", "Server IP", "Date", "Time", "Status" }
             { printf "%-15s %-10s %-8s %s\n", $1, $2, $3, $4 }' "$LOG_FILE" | column -t -s $'\t'
