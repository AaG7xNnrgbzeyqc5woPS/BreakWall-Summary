# See:
 - 🤎 [sing-box搭建vless+vision+reality、vless+h2+reality、vless+grpc+reality节点，简单、安全、稳定，一键脚本+手搓总有一种适合你。](https://www.youtube.com/watch?v=MV7EWSIQ7w8)
 - [Script_installation](https://github.com/TinrLin/Script_installation)
 - [Welcome to the wiki page for the sing-box project](https://sing-box.sagernet.org/)
 - [sing-box ](https://github.com/SagerNet/sing-box)

# 服务器准备
## 1. install debain for vps
## 2. 检查服务器监听的端口
```
  netstat -l
  netstat -ln
  netstat -aln 
```
## 3. install ufw
```
apt update
apt full-upgrade
apt install ufw
ufw status
ufw status verbose
ufw allow ssh
ufw enable
```


## 2. bbr(上面的脚本已经自带bbr开通功能)
```
ow to check if BBR is enabled on your system?

Before enabling BBR, checking if it's already enabled on your system is essential. To do this, run the following command:

sysctl net.ipv4.tcp_congestion_control

If BBR is enabled, you'll see the following output:

net.ipv4.tcp_congestion_control = bbr

If you see a different congestion control algorithm, such as cubic or reno, BBR isn't enabled.
--------------------------------------------------------------------------------------------------
See: 
  [How to check if BBR is enabled on your system?](https://www.linuxcapable.com/how-to-enable-bbr-on-debian-linux/)
```

 ## 3. install singbox script
```
install tutorial
https://github.com/TinrLin/Script_installation/tree/main

#video tutorial
https://www.youtube.com/watch?v=MV7EWSIQ7w8

#config info:
cat /usr/local/etc/sing-box/output.txt


#command
bash <(curl -L https://raw.githubusercontent.com/TinrLin/script_installation/main/Install.sh)


#Config file
cat /usr/local/etc/sing-box/config.json
```

 
