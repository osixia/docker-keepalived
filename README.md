> Before continuing, read the [Recommendations](#recommendations) and [Considerations](#considerations-about-this-project) sections.

# docker-keepalived
This project is based on [```configure.py```](build/configure.py) and allows to dynamically manipulate ```keepalived docker-image```'s behaviors and configurations at build time; for more informations about the installation please see the section: [Build from GitHub](#build-from-github).

Also note that this ```Dockerimage``` is partially based on this commit [acassen/keepalived/pull/2052](https://github.com/acassen/keepalived/pull/2052) and will automaticaly download the ```keepalived``` version specified trought: ```GIT_KVER```.

```
usage: configure.py [-h] [--enable-dbus ENABLE_DBUS] [--disable-libipset DISABLE_LIBIPSET] [--disable-iptables DISABLE_IPTABLES]
                    [--disable-nftables DISABLE_NFTABLES] [--enable-snmp-vrrp ENABLE_SNMP_VRRP] [--enable-regex ENABLE_REGEX]
                    [--enable-regex-timers ENABLE_REGEX_TIMERS] [--enable-json ENABLE_JSON] [--disable-lvs DISABLE_LVS]
                    [--disable-vrrp DISABLE_VRRP] [--disable-vrrp-auth DISABLE_VRRP_AUTH] [--enable-bfd ENABLE_BFD]
                    [--disable-vmac DISABLE_VMAC] [--enable-lto ENABLE_LTO] [--disable-checksum-compact DISABLE_CHECKSUM_COMPACT]
                    [--disable-routes DISABLE_ROUTES] [--disable-linkbeat DISABLE_LINKBEAT] [--enable-sock-storage ENABLE_SOCK_STORAGE]
                    [--disable-fwmark DISABLE_FWMARK] [--disable-track-process DISABLE_TRACK_PROCESS] [--enable-mem-check ENABLE_MEM_CHECK]
                    [--enable-debug ENABLE_DEBUG] [--enable-snmp-alert-debug ENABLE_SNMP_ALERT_DEBUG]
                    [--enable-epoll-debug ENABLE_EPOLL_DEBUG] [--enable-vrrp-fd-debug ENABLE_VRRP_FD_DEBUG]
                    [--enable-recvmsg-debug ENABLE_RECVMSG_DEBUG] [--enable-eintr-debug ENABLE_EINTR_DEBUG]
                    [--enable-parser-debug ENABLE_PARSER_DEBUG] [--enable-checksum-debug ENABLE_CHECKSUM_DEBUG]
                    [--enable-checker-debug ENABLE_CHECKER_DEBUG] [--enable-mem-err-debug ENABLE_MEM_ERR_DEBUG]
                    [--enable-script-debug ENABLE_SCRIPT_DEBUG]
```

# Key features
Key features of ```docker-keepalived```.

| # | Key
| ------------- | ------------- |
| 1 | Dynamically manipulate ```keepalived``` in ```docker``` compilation.  |
| 2 | Downloads ```keepalived``` from GitHub and not from [keepalived.org](https://keepalived.org).  |
| 3 | No pre build is needed.  | 
| 4 | ```docker-compose``` skeleton and support.   |
| 5 | Based on ```alpine linux```.  |
| 6 | Super small size image 	(46 MB).  |
| 7 | You can build this project from the GitHub repo. |

# What has been tested
```keepalived``` is a very smart and robust software with lot of modules (LVS, BFD, VRRP, etc..) and ```docker-keepalived``` is still a new project so we may want to track what we tested and what we should test:

| # | Module | Tested | Notes | 
| ------------- | ------------- | ------------- | ------------- | 
| 1 | VRRP  | Yes | Working fine. |
| 2 | BFD  | Yes | Working fine. |
| 3 | LVS  | Yes | Working fine. |
| 4 | Track script  | Yes | Working fine (with limitations). |
| 5 | Track process  | No | It does not work in a single process environment. |
| 6 | Track file | Yes | Working fine. |
| 7 | SNMP | No |  |
| 8 | SIGKILL output  | Yes | Signals are intercepted by ```keepalived```.|

# Recommendations

| # | Key |
| ------------- | ------------- |
| 1 | Take a look to this interesting issue [#665](https://github.com/acassen/keepalived/issues/665).  |
| 2 | Take a look to this commit [#2052](https://github.com/acassen/keepalived/pull/2052).  |
| 3 | From [#665](https://github.com/acassen/keepalived/issues/665): "My concern is that ```keepalived``` operates quite close to the kernel, significantly more so than most applications, and hence my questions to make sure that it really will work within a Docker environment." |
| 4 | Remeber that ```keepalived``` is unable to load the ```ip_tables```, ```ip6_tables```, ```xt_set``` and ```ip_vs``` modules from within the container, so ensure they are already loaded in the host system. |
| 5* | It is important that ```keepalived``` is shutdown before the container is removed, otherwise ```iptables```, ```ipsets``` and ```ipvs``` configuration can be left over in the host after the container terminates. |

*```docker-compose``` has a work-around for this; reference: [stop_grace_period](https://docs.docker.com/compose/compose-file/compose-file-v3/#stop_grace_period).

# Considerations about this project

The Docker environment (```docker-keepalived```) is a really interesting virtual space for security reasons, but there are some apps that operates quite close to the kernel, significantly more then others, so if you really want to use ```keepalived``` and its advantages, or you simply want to use it in a complex production environment, you might need to build it directly on your host, please see: [INSTALL](https://github.com/acassen/keepalived/blob/master/INSTALL).

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
