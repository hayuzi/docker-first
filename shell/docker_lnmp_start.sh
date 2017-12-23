#!/bin/sh

## ==========
## docker restart and recover the containers
## ==========

## restart docker
# systemctl restart docker

## mysql  ip: 172.17.0.2
docker start mymysql

## php  ip: 172.17.0.3
docker start myphp-fpm

## openresty  ip: 172.17.0.1
# use "--net=host" options when run, so it shares the same ip with the master machine
docker start mynginx

## php-swoole ip: 172.17.0.4
docker start myswoole

## docker inspect --format='{{.NetworkSettings.IPAddress}}' mymysql   
## docker inspect --format='{{.NetworkSettings.IPAddress}}' myphp-fpm   
## docker inspect --format='{{.NetworkSettings.IPAddress}}' mynginx   
## docker inspect --format='{{.NetworkSettings.IPAddress}}' myswoole