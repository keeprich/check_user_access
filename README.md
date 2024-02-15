

# SSH Script

This Bash script allows you to remotely SSH into multiple servers specified by their IP addresses and perform certain actions. It reads passwords from a `password.txt` file, SSHs into each server, and creates a file named ==> (for TESTING ONLY) `kennethFile_<IP>_<date>.txt` on each server.

## Usage

1. Make sure you have `sshpass` installed on your system. If not, you can install it using `sudo apt install sshpass` on Debian-based systems or `sudo yum install sshpass` on CentOS-based systems.

2. Create a `password.txt` file in the same directory as the script. Add passwords corresponding to each server IP address, with each password on a new line.

3. Modify the `SERVERS` array in the script to include the IP addresses of the servers you want to SSH into.

4. Run the script by executing `./my.sh` in your terminal.

5. The script will SSH into each server, create a file on each server, and log the status of each operation in `ssh_log.txt`.

6. After the script completes, it triggers `backup.sh` to run, which backs up the `ssh_log.txt` file.

## File Descriptions

- `my.sh`: The main script file that performs SSH operations and logs the status.
- `password.txt`: Contains passwords corresponding to each server IP address.
- `ssh_log.txt`: Logs the status of each SSH operation.
- `backup.sh`: Script to backup the `ssh_log.txt` file.

## Note

Make sure to set the appropriate permissions on the script files (`my.sh` and `backup.sh`) using `chmod +x <filename>` to make them executable.

