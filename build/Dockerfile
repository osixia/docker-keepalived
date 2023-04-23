FROM alpine:latest

LABEL author="Alexandre Cassen <acassen@gmail.com>"
LABEL project="https://github.com/acassen/keepalived"
LABEL homepage="https://www.keepalived.org"

ARG GIT_KVER=master
ARG MAP_FROM='local'
ARG WDIR=/usr/src/keepalived

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

RUN apk --no-cache add \
        python3 \
        git \
        binutils \
        gcc \
        libnl3 \
        libnl3-dev \
        make \
        musl-dev \
        openssl \
        openssl-dev \
        autoconf \
        automake
RUN if [[ $__ENABLE_MAGIC__     -eq 1 ]]; then apk --no-cache add file file-dev;           fi
RUN if [[ $__ENABLE_DBUS__      -eq 1 ]]; then apk --no-cache add glib glib-dev;           fi
RUN if [[ $__DISABLE_IPSET__    -eq 0 ]]; then apk --no-cache add ipset ipset-dev;         fi
RUN if [[ $__DISABLE_IPTABLES__ -eq 0 ]]; then apk --no-cache add iptables iptables-dev;   fi
RUN if [[ $__DISABLE_NFTABLES__ -eq 0 ]]; then apk --no-cache add libmnl-dev libnftnl-dev; fi
RUN if [[ $__ENABLE_SNMP_VRRP__ -eq 1 ]]; then apk --no-cache add net-snmp-dev;            fi
RUN if [[ $__ENABLE_REGEX__     -eq 1 ]]; then apk --no-cache add pcre2 pcre2-dev;         fi

RUN git clone -b $GIT_KVER https://github.com/acassen/keepalived.git $WDIR

WORKDIR $WDIR

ADD configure.py ./configure.py
ADD configure.json ./configure.json
RUN if [[ ! $MAP_FROM == "local" ]]; then wget $MAP_FROM -O configure.json; fi

RUN ./autogen.sh

RUN chmod +x ./configure.py

RUN ./configure.py \
        --enable-dbus              $__ENABLE_DBUS__ \
        --disable-libipset         $__DISABLE_IPSET__ \
        --disable-iptables         $__DISABLE_IPTABLES__ \
        --disable-nftables         $__DISABLE_NFTABLES__ \
        --enable-snmp-vrrp         $__ENABLE_SNMP_VRRP__ \
        --enable-regex             $__ENABLE_REGEX__ \
        --enable-regex-timers      $__ENABLE_REGEX_TIMERS__ \
        --enable-json              $__ENABLE_JSON__ \
        --disable-lvs              $__DISABLE_LVS__ \
        --disable-vrrp             $__DISABLE_VRRP__ \
        --disable-vrrp-auth        $__DISABLE_VRRP_AUTH__ \
        --enable-bfd               $__ENABLE_BFD__ \
        --disable-vmac             $__DISABLE_VMAC__ \
        --enable-lto               $__ENABLE_LTO__ \
        --disable-checksum-compact $__DISABLE_CHECKSUM_COMPACT__ \
        --disable-routes           $__DISABLE_ROUTES__ \
        --disable-linkbeat         $__DISABLE_LINKBEAT__ \
        --enable-sock-storage      $__ENABLE_SOCK_STORAGE__ \
        --disable-fwmark           $__DISABLE_FWMARK__ \
        --enable-mem-check         $__ENABLE_MEM_CHECK__ \
        --enable-debug             $__ENABLE_DEBUG__ \
        --disable-track-process    $__DISABLE_TRACK_PROCESS__ \
        --enable-snmp-alert-debug  $__ENABLE_SNMP_ALERT_DEBUG__ \
        --enable-epoll-debug       $__ENABLE_EPOLL_DEBUG__ \
        --enable-vrrp-fd-debug     $__ENABLE_VRRP_FD_DEBUG__ \
        --enable-recvmsg-debug     $__ENABLE_RECVMSG_DEBUG__ \
        --enable-eintr-debug       $__ENABLE_EINTR_DEBUG__ \
        --enable-parser-debug      $__ENABLE_PARSER_DEBUG__ \
        --enable-checksum-debug    $__ENABLE_CHECKSUM_DEBUG__ \
        --enable-checker-debug     $__ENABLE_CHECKER_DEBUG__ \
        --enable-mem-err-debug     $__ENABLE_MEM_ERR_DEBUG__ \
        --enable-script-debug      $__ENABLE_SCRIPT_DEBUG__

RUN make && make install

RUN apk --no-cache del \
        python3 \
        git \
        binutils \
        gcc \
        libnl3-dev \
        make \
        musl-dev \
        openssl-dev \
        autoconf \
        automake
RUN if [[ $__ENABLE_MAGIC__     -eq 1 ]]; then apk --no-cache del file-dev;                fi
RUN if [[ $__ENABLE_DBUS__      -eq 1 ]]; then apk --no-cache del glib-dev;                fi
RUN if [[ $__DISABLE_IPSET__    -eq 0 ]]; then apk --no-cache del ipset-dev;               fi
RUN if [[ $__DISABLE_IPTABLES__ -eq 0 ]]; then apk --no-cache del iptables-dev;            fi
RUN if [[ $__DISABLE_NFTABLES__ -eq 0 ]]; then apk --no-cache del libmnl-dev libnftnl-dev; fi
RUN if [[ $__ENABLE_SNMP_VRRP__ -eq 1 ]]; then apk --no-cache del net-snmp-dev;            fi
RUN if [[ $__ENABLE_REGEX__     -eq 1 ]]; then apk --no-cache del pcre2-dev;               fi

RUN rm -rf $WDIR/*

RUN addgroup -S keepalived_script && adduser -D -S -G keepalived_script keepalived_script

ENTRYPOINT ["/usr/sbin/keepalived","--dont-fork","--log-console", "-f", "/etc/keepalived/keepalived.conf"]
