#!/usr/bin/expect -f
# Script to Copy files from sftp server

spawn sftp <server detail>
expect  "password:"
send "<password>\r"
expect "sftp>"
send "get <path/to/file>\r"
send "exit\r"
interact

