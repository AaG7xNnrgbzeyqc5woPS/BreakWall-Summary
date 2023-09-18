# 0. See:
- [在 sing-box 上安装 reality 和 hysteria2](https://blog.mareep.net/posts/15209/)
- [【最稳和最快】在sing-box上安装reality和hysteria2。无需域名，自签100年证书，配置简洁清爽，随时切换体验稳定与飞速的感觉](https://www.youtube.com/watch?v=hbrOxWrGmTc)
- [配置示例 sing-box-examples](https://github.com/chika0801/sing-box-examples/tree/main)

# 1. 前言
  无需域名，使用自签证书配置 hysteria2
  
  **补充的话**
做这个视频之前我一直在想 tuic v5 和 hysteria2 到底做哪个好，最后我选择了 hysteria2。我没有仔细对比过这两种协议，但是我还是选择了 hy2
因为 hysteria 的作者真的很贴心，他的文档是我见过写的相当好的文档了，不过用 sb 内核好像和原作者的文档没啥关系吧。
当然如果你想安装 reality 和 tuic 的话，tuic 也是可以用自签证书的，所以这篇文章，你只需要把 hy2 换成 tuic 即可，然后我在给你们推荐一个仓库，可以去这个仓库里面找配置文件。
[sing-box-example](https://github.com/chika0801/sing-box-examples/tree/main)

# 2. 一键脚本

如果你是懒人，那我这里写了个一键脚本，自取。(注释：没有测试  - by 乱码)
```
bash <(curl -fsSL https://github.com/vveg26/sing-box-reality-hysteria2/raw/main/install.sh)
```

# 3. 安装
- 注释1：我的理解，安装服务器和客户机都是一样的流程，区别只在于配置文件
- 注释2：客户机不好连接外网，可以拷贝服务器上的程序 /usr/local/bin/sing-box， 顺便拷贝两个文件： /etc/systemd/system/sing-box.service, /usr/local/etc/sing-box/config.json

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

|  项目       |                                      | 
|:-----------|---------------------------------------|
|程序 	       | /usr/local/bin/sing-box               |
|配置 	       | /usr/local/etc/sing-box/config.json   |
|geoip 	     | /usr/local/share/sing-box/geoip.db    |
|geosite 	   | /usr/local/share/sing-box/geosite.db  |
|重启 	       | systemctl restart sing-box            |
|状态 	       | systemctl status sing-box             |
|查看日志 	   | journalctl -u sing-box -o cat -e      |
|实时日志 	   | journalctl -u sing-box -o cat -f      |

# 4. 服务器端
## 4.1 服务器端自签证书
用自签证书的好处就是不需要有自己的域名，需要开启允许不安全连接，这种方式会增加一点点被中间人攻击的风险（概率基本为 0）
为 bing.com 生成一个 100 年的自签证书
```
mkdir -p /root/hysteria && openssl ecparam -genkey -name prime256v1 -out /root/hysteria/private.key && openssl req -new -x509 -days 36500 -key /root/hysteria/private.key -out /root/hysteria/cert.pem -subj "/CN=bing.com"
```
## 4.2 编辑服务器端配置文件
编辑
```
nano /usr/local/etc/sing-box/config.json
```
替换
```
{
    "inbounds": [
        {
            "type": "hysteria2",
            "listen": "::",
            "listen_port": 8443,
            "users": [
                {
                    "password": "" //your password
                }
            ],
            "tls": {
                "enabled": true,
                "alpn": [
                    "h3"
                ],
                "certificate_path": "/root/hysteria/cert.pem", //证书路径
                "key_path": "/root/hysteria/private.key"
            }
        },
        {
            "type": "vless",
            "listen": "::",
            "listen_port": 443,
            "users": [
                {
                    "uuid": "", //sing-box generate uuid
                    "flow": "xtls-rprx-vision"
                }
            ],
            "tls": {
                "enabled": true,
                "server_name": "www.lovelive-anime.jp", //偷取证书的域名，tls1.3，h2
                "reality": {
                    "enabled": true,
                    "handshake": {
                        "server": "www.lovelive-anime.jp", //偷取证书的域名
                        "server_port": 443
                    },
                    "private_key": "", //sing-box generate reality-keypair
                    "short_id": [
                        "b2c86d5449d237fa"
                    ]
                }
            }
        }
    ],
    "outbounds": [
        {
            "type": "direct"
        }
    ]
}

```

# 5. 客户端
sing-box 客户端配置文件
```
{
  "dns": {
    "rules": [
      {
        "clash_mode": "global",
        "server": "remote"
      },
      {
        "clash_mode": "direct",
        "server": "local"
      },
      {
        "outbound": [
          "any"
        ],
        "server": "local"
      },
      {
        "geosite": "cn",
        "server": "local"
      }
    ],
    "servers": [
      {
        "address": "https://1.1.1.1/dns-query",
        "detour": "select",
        "tag": "remote"
      },
      {
        "address": "https://223.5.5.5/dns-query",
        "detour": "direct",
        "tag": "local"
      }
    ],
    "strategy": "ipv4_only"
  },
  "experimental": {
    "clash_api": {
      "external_controller": "127.0.0.1:9090",
      "secret": "",
      "store_selected": true
    }
  },
  "inbounds": [
    {
      "auto_route": true,
      "domain_strategy": "ipv4_only",
      "endpoint_independent_nat": true,
      "inet4_address": "172.19.0.1/30",
      "mtu": 9000,
      "sniff": true,
      "sniff_override_destination": true,
      "strict_route": true,
      "type": "tun"
    },
    {
      "domain_strategy": "ipv4_only",
      "listen": "127.0.0.1",
      "listen_port": 2333,
      "sniff": true,
      "sniff_override_destination": true,
      "tag": "socks-in",
      "type": "socks",
      "users": []
    },
    {
      "domain_strategy": "ipv4_only",
      "listen": "127.0.0.1",
      "listen_port": 2334,
      "sniff": true,
      "sniff_override_destination": true,
      "tag": "mixed-in",
      "type": "mixed",
      "users": []
    }
  ],
  "log": {
    "disabled": false,
    "level": "info",
    "timestamp": true
  },
  "outbounds": [
    {
      "tag": "select",
      "type": "selector",
      "default": "urltest",
      "outbounds": [
        "urltest",
        "sing-box-reality",
        "sing-box-hysteria2"
      ]
    },
    {
      "type": "vless",
      "tag": "sing-box-reality",
      "uuid": "0000-0000-0000-0000-0000", //你的uuid
      "flow": "xtls-rprx-vision",
      "packet_encoding": "xudp",
      "server": "13.115.159.101", //你的ip地址
      "server_port": 443, //reality端口号
      "tls": {
        "enabled": true,
        "server_name": "www.lovelive-anime.jp", //修改为你的偷取的网站
        "utls": {
          "enabled": true,
          "fingerprint": "chrome"
        },
        "reality": {
          "enabled": true,
          "public_key": "BPsRHmIOWpRsRpCKbal9Q2zWjHOrBd7_6SoEyXYu0yQ", //修改为你的public-key
          "short_id": "b2c86d5449d237fa"   //修改为你的shortid
        }
      }
    },
    {
      "type": "hysteria2",
      "server": "13.115.159.101", //你的vps ip地址
      "server_port": 8443,   //hy2端口号
      "tag": "sing-box-hysteria2",
      "up_mbps": 30,
      "down_mbps": 150,  //拥塞控制，根据自己的带宽填也可以跟我一样
      "password": "mianyang", //你的hysteria2密码
      "tls": {
        "enabled": true,
        "server_name": "bing.com", //自签域名
        "insecure": true, //自签就true，不自签false，跳过证书验证
        "alpn": [
          "h3"
        ]
      }
    },
    {
      "tag": "direct",
      "type": "direct"
    },
    {
      "tag": "block",
      "type": "block"
    },
    {
      "tag": "dns-out",
      "type": "dns"
    },
    {
      "tag": "urltest",
      "type": "urltest",
      "outbounds": [
        "sing-box-reality",
        "sing-box-hysteria2"
      ]
    }
  ],
  "route": {
    "auto_detect_interface": true,
    "rules": [
      {
        "geosite": "category-ads-all",
        "outbound": "block"
      },
      {
        "outbound": "dns-out",
        "protocol": "dns"
      },
      {
        "clash_mode": "direct",
        "outbound": "direct"
      },
      {
        "clash_mode": "global",
        "outbound": "select"
      },
      {
        "geoip": [
          "cn",
          "private"
        ],
        "outbound": "direct"
      },
      {
        "geosite": "geolocation-!cn",
        "outbound": "select"
      },
      {
        "geosite": "cn",
        "outbound": "direct"
      }
    ]
  }
}

```


