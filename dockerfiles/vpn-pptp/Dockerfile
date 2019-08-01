# vpn-pptp
# 
# VERSION               0.0.1
#
# MAINTAINER hayuzi hayuzi@163.com

## 初次构建并启动容器之后, 再进入容器中运行如下内容
## echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf                         //支持IP转发
## sysctl -p
## iptables -t nat -A POSTROUTING -s 10.10.10.0/24 -o eth0 -j MASQUERADE    // iptables支持转发
## iptables save

FROM debian:wheezy

USER root

RUN apt-get update && \
    apt-get install -y pptpd iptables && \
    && rm -rf /var/lib/apt/lists/* \
    && echo "ms-dns 8.8.8.8" >> /etc/ppp/options.pptpd \
    && echo "ms-dns 8.8.4.4" >> /etc/ppp/options.pptpd \
    && echo "username  pptpd  password *"   >> /etc/ppp/chap-secrets \
    && echo "localip   10.10.10.9"          >> /etc/pptpd.conf \
    && echo "remoteip  10.10.10.100-200"    >> /etc/pptpd.conf
    



EXPOSE 1723

CMD  ["pptpd", "--fg"]

