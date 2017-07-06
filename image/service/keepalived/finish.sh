#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

# try to delete virtual ips from interface
for vip in $(complex-bash-env iterate KEEPALIVED_VIRTUAL_IPS)
do
  IP=$(echo ${!vip} | awk '{print $1}')
  IP_INFO=$(ip addr list | grep ${IP}) || continue
  IP_V6=$(echo "${IP_INFO}" | grep "inet6") || true

  # ipv4
  if [ -z "${IP_V6}" ]; then
    IP_INTERFACE=$(echo "${IP_INFO}" |  awk '{print $5}')
  # ipv6
  else
    echo "skipping address: ${IP} - ipv6 not supported yet :("
    continue
  fi

  ip addr del ${IP} dev ${IP_INTERFACE} || true
done

exit 0
