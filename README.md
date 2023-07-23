> **Use this repository at your own risk**: [acassen/keepalived](https://github.com/acassen/keepalived) does not provide a ```docker-image```. It is not something that the maintainers of keepalived use, and therefore not something that [acassen/keepalived](https://github.com/acassen/keepalived) could maintain properly; please see: [#2309](https://github.com/acassen/keepalived/issues/2309).

# docker-keepalived
> Before continuing, read the [Recommendations](#recommendations) and [Considerations](#considerations-about-this-project) sections.

This project is based on [```configure.py```](build/configure/configure.py) and allows to dynamically manipulate ```keepalived docker-image```'s behaviors and configurations at build time; for more informations about the compilation please see the sections: [Build from GitHub](#build-from-github) or [Install from DockerHub](#install-from-dockerhub).

Also note that this ```Dockerimage``` is partially based on this commit [acassen/keepalived/pull/2052](https://github.com/acassen/keepalived/pull/2052) and will automaticaly clone the ```keepalived``` version specified via: ```GIT_KVER``` through GitHub (default is ```master```).

# Key features
Key features of ```docker-keepalived```.

| # | Key |
| ------------- | ------------- |
| 1 | Dynamically manipulate ```keepalived``` in ```docker``` compilation.  |
| 2 | Downloads ```keepalived``` from GitHub and not from [keepalived.org](https://keepalived.org).  |
| 3 | No pre build is needed.  | 
| 4 | ```docker-compose``` skeleton and support.   |
| 5 | Based on ```alpine linux```.  |
| 6 | Super small size image 	(46 MB).  |
| 7 | You can build this project from the GitHub repo. |

# Recommendations

| # | Key |
| ------------- | ------------- |
| 1 | [acassen/keepalived](https://github.com/acassen/keepalived) does not provide a ```docker-image```. It is not something that the maintainers of keepalived use, and therefore not something that [acassen/keepalived](https://github.com/acassen/keepalived) could maintain properly.  |
| 2 | Take a look to those interesting issues [#665](https://github.com/acassen/keepalived/issues/665) and  [#2309](https://github.com/acassen/keepalived/issues/2309)   |
| 3 | Take a look to this commit [#2052](https://github.com/acassen/keepalived/pull/2052).  |
| 4 | From [#665](https://github.com/acassen/keepalived/issues/665): "My concern is that ```keepalived``` operates quite close to the kernel, significantly more so than most applications, and hence my questions to make sure that it really will work within a Docker environment." |
| 5 | Remeber that ```keepalived``` is unable to load the ```ip_tables```, ```ip6_tables```, ```xt_set``` and ```ip_vs``` modules from within the container, so ensure they are already loaded in the host system. |
| 6* | It is important that ```keepalived``` is shutdown before the container is removed, otherwise ```iptables```, ```ipsets``` and ```ipvs``` configuration can be left over in the host after the container terminates. |

*```docker-compose``` has a work-around for this; reference: [stop_grace_period](https://docs.docker.com/compose/compose-file/compose-file-v3/#stop_grace_period).

# Considerations about this project

The Docker environment (```docker-keepalived```) is a really interesting virtual space for security and automation reasons, but there are some apps that operates quite close to the kernel, significantly more then others, so if you really want to use ```keepalived``` and its advantages, or you simply want to use it in a complex production environment, you might need to build it directly on your host, please see: [INSTALL](https://github.com/acassen/keepalived/blob/master/INSTALL).

If you are worry about security, remember that you can run ```keepalived``` as non-root user, please see: [keepalived-non-root.service](https://github.com/acassen/keepalived/blob/master/keepalived/keepalived-non-root.service.in), which is not the same that runs scripts.

# Build from GitHub
There are a lot of choices to build this image.

## ```docker build```
```
docker build \
    -t keepalived \
    --build-arg GIT_KVER=master \
    --build-arg __ENABLE_JSON__=1 \
     https://github.com/nser77/docker-keepalived.git#main:build
```

## ```docker-compose```
Download the  [```docker-compose```](compose/docker-compose.yml) file and use it as following:

```
docker-compose -f docker-compose.yml build
```

# ```build-args```
At build time, one or more of the following arguments can be specified via ```--build-arg``` to modify the ```keepalived``` configuration; those arguments can also be used from [```docker-compose```](compose/docker-compose.yml).

Defaults are:

```
# keepalived git branch
ARG GIT_KVER=master

ARG __ENABLE_MAGIC__=0
ARG __ENABLE_DBUS__=0
ARG __DISABLE_IPSET__=0
ARG __DISABLE_IPTABLES__=0
ARG __DISABLE_NFTABLES__=0
ARG __ENABLE_SNMP_VRRP__=0
ARG __ENABLE_REGEX__=0
ARG __ENABLE_REGEX_TIMERS__=0
ARG __ENABLE_JSON__=0
ARG __DISABLE_LVS__=0
ARG __DISABLE_VRRP__=0
ARG __DISABLE_VRRP_AUTH__=0
ARG __ENABLE_BFD__=0
ARG __DISABLE_VMAC__=0
ARG __ENABLE_LTO__=0
ARG __DISABLE_CHECKSUM_COMPACT__=0
ARG __DISABLE_ROUTES__=0
ARG __DISABLE_LINKBEAT__=0
ARG __ENABLE_SOCK_STORAGE__=0
ARG __DISABLE_FWMARK__=0
ARG __DISABLE_TRACK_PROCESS__=0
ARG __ENABLE_MEM_CHECK__=0
ARG __ENABLE_DEBUG__=0
ARG __ENABLE_SNMP_ALERT_DEBUG__=0
ARG __ENABLE_EPOLL_DEBUG__=0
ARG __ENABLE_VRRP_FD_DEBUG__=0
ARG __ENABLE_RECVMSG_DEBUG__=0
ARG __ENABLE_EINTR_DEBUG__=0
ARG __ENABLE_PARSER_DEBUG__=0
ARG __ENABLE_CHECKSUM_DEBUG__=0
ARG __ENABLE_CHECKER_DEBUG__=0
ARG __ENABLE_MEM_ERR_DEBUG__=0
ARG __ENABLE_SCRIPT_DEBUG__=0
```

# Install from DockerHub
This image is also available on DockerHub: [nser77/docker-keepalived](https://hub.docker.com/repository/docker/nser77/docker-keepalived/general).
