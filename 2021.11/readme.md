# 0. See:
 - [trojan-one-key-script-install](https://github.com/AaG7xNnrgbzeyqc5woPS/trojan-one-key-script-install)  Dec 1, 2019
 - [trojan多用户管理部署程序(backup)](https://github.com/AaG7xNnrgbzeyqc5woPS/trojan-2)  Sep 22 2021
 - ❤️[trojan多用户管理部署程序](https://github.com/Jrohy/trojan)                       10 days ago , 2021
 - [ AaG7xNnrgbzeyqc5woPS/trojan-1 ](https://github.com/AaG7xNnrgbzeyqc5woPS/trojan-1) Nov 9, 2020
 - [ trojan-gfw/trojan ](https://github.com/trojan-gfw/trojan)        Nov 9, 2020
 - [ AaG7xNnrgbzeyqc5woPS/XRay_Trojan_Docker ](https://github.com/AaG7xNnrgbzeyqc5woPS/XRay_Trojan_Docker)  May 28, 2021
 - ❤️[XRay_Trojan_Docker](https://github.com/maidoudouo/XRay_Trojan_Docker)  May 28, 2021
 - [Qv2ray /Qv2ray ](https://github.com/Qv2ray/Qv2ray)
 - [AaG7xNnrgbzeyqc5woPS/Qv2ray](https://github.com/AaG7xNnrgbzeyqc5woPS/Qv2ray)
 - [ AaG7xNnrgbzeyqc5woPS /trojan-go ](https://github.com/AaG7xNnrgbzeyqc5woPS/trojan-go)
 - ❤️[ p4gefau1t /trojan-go](https://github.com/p4gefau1t/trojan-go)
 - [ AaG7xNnrgbzeyqc5woPS /all_install](https://github.com/AaG7xNnrgbzeyqc5woPS/all_install)
 - [ JeannieStudio /all_install ](https://github.com/JeannieStudio/all_install)
 - [ AaG7xNnrgbzeyqc5woPS /trojan-qt5 ](https://github.com/AaG7xNnrgbzeyqc5woPS/trojan-qt5)
 - [ AaG7xNnrgbzeyqc5woPS /trojan-caddy-docker-compose ]( https://github.com/AaG7xNnrgbzeyqc5woPS/trojan-caddy-docker-compose )
 - [ FaithPatrick /trojan-caddy-docker-compose ](https://github.com/FaithPatrick/trojan-caddy-docker-compose)
 - [ 0758jian /docker-compose-trojan ](https://github.com/0758jian/docker-compose-trojan)
 - [ AaG7xNnrgbzeyqc5woPS /docker-compose-trojan ](https://github.com/AaG7xNnrgbzeyqc5woPS/docker-compose-trojan)
 - 


# 1. See:
  - [FanQiang-Book——2021 科学上网指南](https://github.com/xiaoming-ssr/FanQiang-Book)
  - [AaG7xNnrgbzeyqc5woPS/FanQiang-Book ](https://github.com/AaG7xNnrgbzeyqc5woPS/FanQiang-Book)
  - [翻墙、科学上网工具＆VPN梯子推荐](https://github.com/AaG7xNnrgbzeyqc5woPS/fanqiang-vpn.github.io)  Aug 10, 2021

# 2. acme.sh
  - [ AaG7xNnrgbzeyqc5woPS/acme.sh ](https://github.com/AaG7xNnrgbzeyqc5woPS/acme.sh)
  - [ acmesh-official/acme.sh ](https://github.com/acmesh-official/acme.sh)
  - 
# 3. 2021.11.10开通
   - 服务器端使用 ❤️[XRay_Trojan_Docker](https://github.com/maidoudouo/XRay_Trojan_Docker)
   - 客户端使用   ❤️[ p4gefau1t /trojan-go](https://github.com/p4gefau1t/trojan-go)
   
##  服务器端安装和配置
  1. 安装Docker,docker-compose, git, TCP-BBR
  2. 下载源码：git clone https://github.com/maidoudouo/XRay_Trojan_Docker
  3. 一键脚本设置：./OneKeySet.sh, **只需要输入域名**，脚本设置好配置后，输出配置信息并且写入info.txt文件
  4. 构建并启动服务：docker-compose up -d
  5. 伪站配置：只需要将网站放入caddy/www里面即可
  6. 调试： 
     - docker-compose ps 能看到两个服务正常运行，up状态
     - docker-compose logs 查看日志
     - tree caddy 能看到申请到的证书，有3个文件，申请证书这个最容易出问题
     - 如果申请证书失败，换个域名，并且等域名配置生效，能ping 通再次配置
     - 再次配置的时候，要 docker-compose down 停止和删除容器，
     - 并且 使用 rm -rf XRay_Trojan_Docker
     - 最后 回到上面的第二步，下载源码，重新尝试 
  
## 客户端配置和启动命令
  **客户端的配置信息参见服务器的 info.txt文件，关键是 域名和密码！**
  
  
   ```
   
客户端 配置文件：
$ cat config.yaml 
run-type: client
local-addr: 127.0.0.1
local-port: 1080
remote-addr: www.example.com
remote-port: 443
password:
  - ***********

   
   # 客户端启动命令
podman run \
    --name trojan-go \
    -d \
    -v /home/John/.trojan-go:/etc/trojan-go \
    --network host \
    p4gefau1t/trojan-go \
    /etc/trojan-go/config.yaml 
    
 ```
