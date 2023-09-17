#!/usr/bin/env bash

# backup at sing-box server
# sb_backup.sh
# check ok! 2023-9-17

mkdir sb_server_file_3
cp /etc/systemd/system/sing-box.service sb_server_file_3/.
cp /usr/local/bin/sing-box  sb_server_file_3/.
cp /usr/local/etc/sing-box/config.json sb_server_file_3/.
