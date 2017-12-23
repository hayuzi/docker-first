#!/bin/sh

## ==========
## docker restart and recover the containers
## ==========

## restart docker
# systemctl restart docker

## mysql
docker run -p 3306:3306 --name mymysql -v /opt/mysql/conf:/etc/mysql -v /opt/mysql/logs:/var/log/mysql -v /opt/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -d hayuzi/mysql:5.6
## 启动一个 mysql 客户端连接到其他mysql服务端
# docker run -it --rm hayuzi/mysql:5.6 mysql -h172.17.0.1 -ublog -p

## php
docker run -p 9000:9000 --name  myphp-fpm -v /opt/nginx/www/html:/var/www/html -v /opt/php-fpm/etc/php:/usr/local/etc/php -v /opt/php-fpm/logs:/phplogs -d hayuzi/php:7.1-fpm-07

## openresty
# docker run -d --name mynginx -p 80:80 -v /opt/nginx/conf:/usr/local/openresty/nginx/conf -v /opt/nginx/logs:/usr/local/openresty/nginx/logs -v /opt/nginx/www/html:/usr/local/openresty/nginx/html hayuzi/openresty:1.9.15.1-trusty
## notice: can not use this on macOS
## mac环境中使用 --net=host 不能正常运行
docker run -d --name mynginx --net=host -v /opt/nginx/conf:/usr/local/openresty/nginx/conf -v /opt/nginx/logs:/usr/local/openresty/nginx/logs -v /opt/nginx/www/html:/usr/local/openresty/nginx/html hayuzi/openresty:1.9.15.1-trusty

## php-swoole
# docker run -p 9050:9050 --name  myswoole  -v /opt/nginx/www/html:/var/www/html -v /opt/php-test/etc/php:/usr/local/etc/php -v /opt/php-test/logs:/phplogs  -d  hayuzi/php:7.1-fpm-06



## redis
docker run -p:6379:6379 --name myredis  -v /opt/redis/conf/redis.conf:/usr/local/etc/redis/redis.conf  -v  /opt/redis/data:/data  -d redis:3.2 redis-server /usr/local/etc/redis/redis.conf --appendonly yes
## 启动一个 redis-cli 
#  docker run -it --name myrecli --link myredis:redis --rm redis:3.2 redis-cli -h 127.0.0.1 -p 6379


## 查看启动的容器ip
## docker inspect --format='{{.NetworkSettings.IPAddress}}' mymysql   
## docker inspect --format='{{.NetworkSettings.IPAddress}}' myphp-fpm   
## docker inspect --format='{{.NetworkSettings.IPAddress}}' mynginx   
## docker inspect --format='{{.NetworkSettings.IPAddress}}' myswoole   
## docker inspect --format='{{.NetworkSettings.IPAddress}}' myredis   