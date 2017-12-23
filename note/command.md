# docker 常用命令


### docker服务基础命令

```
-------------------- 基础命令 -----------------------

docker version              // 查看版本号

docker info                 // 查看docker基本信息

sudo service docker start   // 启动docker服务

service docker start        // 启动docker服务

service docker stats        // docker 状态

service docker restart      // 重启docker 服务

service docker stop         // 关闭服务


```

### docker的版本与基础信息



```
docker version 

docker info

```



### docker镜像相关命令

```
-------------------- 镜像相关 ------------------------

//  镜像相当于一个类, 而实际从镜像启动运行的容器则相当于一个类的对象

docker search 镜像名称/关键字       // 搜索镜像

docker pull 镜像名                  // 拉取镜像 

docker pull docker.io/openresty/openresty       // 拉取openrestyy镜像
docker pull openresty/openresty:1.9.15.1-trusty // 或者直接拉取固定的版本





docker images               // 查看镜像

docker rmi <image id>       // 删除镜像 , 前提是无这个镜像的容器在运行

docker rmi $(docker images | grep "^<none>" | awk "{print $3}")     // 想要删除untagged images，也就是那些id为<None>的image的话可以用

docker rmi $(docker images -q)  // 删除全部镜像






```

### docker 容器相关操作命令
```

-------------------- 容器生命周期相关 --------------------------

docker run hello-world      // 运行一个 hello-world 的测试容器

docker run ubuntu:15.10 /bin/echo "Hello world"    
    // run命令详解 :   docker       docker命令的二进制文件
    // run命令详解 :   run          与前面的 docker 组合来运行一个容器。
    // run命令详解 :   ubuntu:15.10 指定要运行的镜像，Docker首先从本地主机上查找镜像是否存在，如果不存在，Docker 就会从镜像仓库 Docker Hub 下载公共镜像。
    // run命令详解 :   /bin/echo "Hello world"   在启动的容器里执行的命令
    // 以上命令完整的意思可以解释为：Docker 以 ubuntu15.10 镜像创建一个新容器，然后在容器里执行 bin/echo "Hello world"，然后输出结果。
    
docker run -i -t ubuntu:15.10 /bin/bash     //交互式容器   ---- 我们可以通过运行exit命令或者使用CTRL+D来退出容器。
    // -t:在新容器内指定一个伪终端或终端。
    // -i:允许你对容器内的标准输入 (STDIN) 进行交互。
    
docker run -d ubuntu:15.10 /bin/sh -c "while true; do echo hello world; sleep 1; done"
    // -d:  创建一个以进程方式运行的容器(后台运行)
    

docker stop 容器ID              // 停止一个运行的容器
docker stop 自动分配的容器名        // 停止一个运行的容器
docker stop $(docker ps -a -q)      // 停止所有的容器, 停止之后才能删除镜像

docker kill -s KILL <containerID/Name>  // 杀死一个运行中的容器
docker kill <containerID/Name>          // 杀死一个于心中的容器

docker pause <containerID/Name>         //暂停容器中所有的进程。
docker unpause <containerID/Name>       //恢复容器中所有的进程。

docker create [OPTIONS] IMAGE [COMMAND] [ARG...]    // 创建一个容器,但不启动他, 可以使用多个参数,类似run的参数



docker restart 容器id/容器名    // 正在运行的容器，我们可以使用 docker restart 命令来重启

docker start 容器id/容器名      // 启动已经停止的容器

docker rm 容器ID                // 删除容器, 要删除的容器必须处于停止状态, 否则出错

docker rm $(docker ps -a -q)        // 删除所有的容器


------------------ docker exec -it 命令-----------

docker exec -it <container name> bash
        // 进入docker容器的bash~~  (shell), 该命令可以深入docker容器内部终端


-d :分离模式: 在后台运行
-i :即使没有附加也保持STDIN 打开
-t :分配一个伪终端



    

docker ps                   // 查看运行的容器
docker ps -l                // 查询最后一次创建的容器：

docker logs 容器ID          // 查看容器内的标准输出
docker logs 自动分配的容器名    // 查看容器内的标准输出
docker logs -f 7a38a1ad55c6 // -f:让 dokcer logs 像使用 tail -f 一样来输出容器内部的标准输出。



docker port 容器ID          // ,使用 docker port 可以查看指定 （ID或者名字）容器的某个确定端口映射到宿主机的端口号。
docker port 分配的容器名    // 同上

docker top 容器ID/容器名    // 查看容器内部运行的进程

docker inspect 容器ID/容器名    // 使用 docker inspect 来查看Docker的底层信息。它会返回一个 JSON 文件记录着 Docker 容器的配置和状态信息。




----------------  docker run 的参数详解  --------------
OPTIONS说明：
-a stdin:  指定标准输入输出内容类型，可选 STDIN/STDOUT/STDERR 三项；
-d: 后台运行容器，并返回容器ID；
-i: 以交互模式运行容器，通常与 -t 同时使用；许你对容器内的标准输入 (STDIN) 进行交互。
-t: 为容器重新分配一个伪输入终端，通常与 -i 同时使用；
--name="nginx-lb": 为容器指定一个名称；
--dns 8.8.8.8: 指定容器使用的DNS服务器，默认和宿主一致；
--dns-search example.com: 指定容器DNS搜索域名，默认和宿主一致；
-h "mars": 指定容器的hostname；
-e username="ritchie": 设置环境变量；
--env-file=[]: 从指定文件读入环境变量；
--cpuset="0-2" or --cpuset="0,1,2": 绑定容器到指定CPU运行；
-m :设置容器使用内存最大值；
--net="bridge": 指定容器的网络连接类型，支持 bridge/host/none/container: 四种类型；
--link=[]: 添加链接到另一个容器；
--expose=[]: 开放一个端口或一组端口


-P      // 将容器内部使用的网络端口映射到我们使用的主机上。
        // 示例: docker run -d -P training/webapp python app.py
        // 用 docker ps 查看---- Docker 开放了 5000 端口（默认 Python Flask 端口）映射到主机端口 32769 上。这时我们可以通过浏览器访问WEB应用

-p      // 我们也可以指定 -p 标识来绑定指定端口。
        // 示例: docker run -d -p 5000:5000 training/webapp python app.py
        // 容器内部的 5000 端口映射到我们本地主机的 5000 端口上。

```



### 镜像仓库


```
-----------------镜像仓库操作命令---------------
docker login        // 登录到dockerhub, https://hub.docker.com 
                    // 而后输入你的用户名和密码
docker pull 镜像名        // 拉取镜像

docker push  空间/镜像名:tag    // 推到dockerhub

docker search 镜像名            // 搜索镜像
```

