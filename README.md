# docker-keepalived
This project is based on [```configure.py```](build/configure.py) and allows to dynamically manipulate ```keepalived docker-image```'s behaviors and configurations at build time; for more informations about the installation please see the section: [Build from GitHub](#build-from-github).

Also note that this ```Dockerimage``` is partially based on this commit [acassen/keepalived/pull/2052](https://github.com/acassen/keepalived/pull/2052) and will automaticaly download the ```keepalived``` version specified trought: ```GIT_KVER```.

```
usage: configure.py [-h] [-n] [--enable-dbus ENABLE_DBUS] [--disable-libipset DISABLE_LIBIPSET] [--disable-iptables DISABLE_IPTABLES] [--disable-nftables DISABLE_NFTABLES] [--enable-snmp-vrrp ENABLE_SNMP_VRRP]
                    [--enable-regex ENABLE_REGEX] [--enable-json ENABLE_JSON] [--disable-lvs DISABLE_LVS] [--disable-vrrp DISABLE_VRRP] [--disable-vrrp-auth DISABLE_VRRP_AUTH] [--enable-bfd ENABLE_BFD] [--disable-vmac DISABLE_VMAC]
                    [--enable-lto ENABLE_LTO] [--disable-checksum-compact DISABLE_CHECKSUM_COMPACT] [--disable-routes DISABLE_ROUTES] [--disable-linkbeat DISABLE_LINKBEAT] [--enable-sock-storage ENABLE_SOCK_STORAGE]
                    [--enable-debug ENABLE_DEBUG] [--enable-snmp-alert-debug ENABLE_SNMP_ALERT_DEBUG] [--enable-epoll-debug ENABLE_EPOLL_DEBUG] [--enable-vrrp-fd-debug ENABLE_VRRP_FD_DEBUG] [--enable-recvmsg-debug ENABLE_RECVMSG_DEBUG]
                    [--enable-eintr-debug ENABLE_EINTR_DEBUG] [--enable-parser-debug ENABLE_PARSER_DEBUG] [--enable-checksum-debug ENABLE_CHECKSUM_DEBUG] [--enable-checker-debug ENABLE_CHECKER_DEBUG]
                    [--enable-mem-err-debug ENABLE_MEM_ERR_DEBUG] [--enable-script-debug ENABLE_SCRIPT_DEBUG]
```

# Key features

| # | Key
| ------------- | ------------- |
| 1 | Dynamically manipulate ```keepalived``` in ```docker``` compilation.  |
| 2 | Downloads ```keepalived``` from GitHub and not from [keepalived.org](https://keepalived.org).  |
| 3 | No pre build is needed.  | 
| 4 | ```docker-compose``` skeleton and support.   |
| 5 | Based on ```alpine linux```.  |
| 6 | Small size image.  |
| 7 | You can build this project from the GitHub repo. |

# Build from GitHub
There are a lot of choices to build this image but also some recommendations.

## Recommendations

| # | Key
| ------------- | ------------- |
| 1 | Take a look to this file https://github.com/acassen/keepalived/tree/master/docker.  |
| 2 | Take a look to this interesting issue https://github.com/acassen/keepalived/issues/665.  |
| 3 | Remeber that ```keepalived``` is unable to load the ```ip_tables```, ```ip6_tables```, ```xt_set``` and ```ip_vs``` modules from within the container, so ensure they are already loaded in the host system. |
| 3 | It is important that ```keepalived``` is shutdown before the container is removed, otherwise ```iptables```, ```ipsets``` and ```ipvs``` configuration can be left over in the host after the container terminates. |

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
docker-compose -f docker-compose.yml up
```

## ```args```
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
