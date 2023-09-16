# 0. See:
- [在 sing-box 上安装 reality 和 hysteria2](https://blog.mareep.net/posts/15209/)
- [【最稳和最快】在sing-box上安装reality和hysteria2。无需域名，自签100年证书，配置简洁清爽，随时切换体验稳定与飞速的感觉](https://www.youtube.com/watch?v=hbrOxWrGmTc)
- [配置示例 sing-box-examples](https://github.com/chika0801/sing-box-examples/tree/main)

# 1. 一键脚本
```
bash <(curl -fsSL https://github.com/vveg26/sing-box-reality-hysteria2/raw/main/install.sh)
```

# 2. 安装
- 注释1：我的理解，安装服务器和客户机都是一样的流程，区别只在于配置文件
- 注释2：客户机不好连接外网，可以拷贝服务器上的程序 /usr/local/bin/sing-box
-       顺便拷贝两个文件： /etc/systemd/system/sing-box.service, /usr/local/etc/sing-box/config.json
-
- 
**安装正式版**
```
bash -c "$(curl -L https://sing-box.vercel.app)" @ install
```
**安装预发布版**
```
bash -c "$(curl -L https://sing-box.vercel.app)" @ install --beta
```
**卸载**
```
bash -c "$(curl -L https://sing-box.vercel.app)" @ remove
```

***项目***
```
程序 	/usr/local/bin/sing-box
配置 	/usr/local/etc/sing-box/config.json
geoip 	/usr/local/share/sing-box/geoip.db
geosite 	/usr/local/share/sing-box/geosite.db
重启 	systemctl restart sing-box
状态 	systemctl status sing-box
查看日志 	journalctl -u sing-box -o cat -e
实时日志 	journalctl -u sing-box -o cat -f
```

