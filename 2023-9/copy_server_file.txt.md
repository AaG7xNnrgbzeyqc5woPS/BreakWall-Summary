
```
● sing-box.service - sing-box service
     Loaded: loaded (/etc/systemd/system/sing-box.service; enabled; preset: enabled)
     Active: active (running) since Fri 2023-09-15 03:03:38 UTC; 7h ago
       Docs: https://sing-box.sagernet.org
   Main PID: 7401 (sing-box)
      Tasks: 7 (limit: 1108)
     Memory: 7.2M
        CPU: 358ms
     CGroup: /system.slice/sing-box.service
             └─7401 /usr/local/bin/sing-box run -c /usr/local/etc/sing-box/config.json

Sep 15 08:48:26 localhost sing-box[7401]: DEBUG[20687] [1914415171 0ms] dns: lookup succeed for www.lovelive-anime.jp: 204.246.191.13 204.246.191.5 204.246.191.3 204.246.191.42
Sep 15 08:50:57 localhost sing-box[7401]: ERROR[20838] [1914415171 2m31s] inbound/vless[1]: process connection from 94.156.6.28:61000: REALITY: processed invalid connection
Sep 15 08:58:26 localhost sing-box[7401]: INFO[21288] [3200942590 0ms] inbound/vless[1]: inbound connection from 45.79.181.179:22396
Sep 15 08:58:26 localhost sing-box[7401]: DEBUG[21288] [3200942590 0ms] dns: lookup domain www.lovelive-anime.jp
Sep 15 08:58:27 localhost sing-box[7401]: DEBUG[21288] [3200942590 247ms] dns: lookup succeed for www.lovelive-anime.jp: 3.163.180.108 3.163.180.40 3.163.180.11 3.163.180.8
Sep 15 08:58:27 localhost sing-box[7401]: ERROR[21288] [3200942590 313ms] inbound/vless[1]: process connection from 45.79.181.179:22396: REALITY: processed invalid connection
Sep 15 09:11:38 localhost sing-box[7401]: INFO[22080] [2084407631 0ms] inbound/vless[1]: inbound connection from 185.224.128.197:53512
Sep 15 09:11:38 localhost sing-box[7401]: DEBUG[22080] [2084407631 0ms] dns: lookup domain www.lovelive-anime.jp
Sep 15 09:11:38 localhost sing-box[7401]: DEBUG[22080] [2084407631 45ms] dns: lookup succeed for www.lovelive-anime.jp: 3.163.180.40 3.163.180.108 3.163.180.11 3.163.180.8
Sep 15 09:11:38 localhost sing-box[7401]: ERROR[22080] [2084407631 191ms] inbound/vless[1]: process connection from 185.224.128.197:53512: REALITY: processed invalid connection

backup at sing-box server
sb_backup.sh
0. mkdir sb_server_file_3
1. cp /etc/systemd/system/sing-box.service sb_server_file_3/.
2. cp /usr/local/bin/sing-box  sb_server_file_3/.
3. cp /usr/local/etc/sing-box/config.json sb_server_file_3/.

restore at sing-box client
sb_restore.sh
0. echo start restore
0. mkdir -p /usr/local/etc/sing-box/
1. cp sb_server_file_3/sing-box.service  /etc/systemd/system/.
2. cp sb_server_file_3/sing-box          /usr/local/bin/.
3. cp sb_server_file_3/config.json       /usr/local/etc/sing-box/.



uninstall_client.sh
systemctl stop sing-box.service
systemctl disable sing-box.service
rm -f  /etc/systemd/system/sing-box.service
rm -f  /usr/local/bin/sing-box
rm -rf /usr/local/etc/sing-box/



```
