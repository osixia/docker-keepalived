#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

# try to delete virtual ips from interface
for vip in $(complex-bash-env iterate KEEPALIVED_VIRTUAL_IPS)
do
  ip addr del ${!vip}/32 dev ${KEEPALIVED_INTERFACE} || true
done

exit 0
