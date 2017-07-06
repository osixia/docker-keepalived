#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

echo -n "Waiting config file /usr/local/etc/keepalived/keepalived.conf"
while [ ! -e "/usr/local/etc/keepalived/keepalived.conf" ]
do
  echo -n "."
  sleep 0.1
done
echo "ok"

exec /usr/local/sbin/keepalived -f /usr/local/etc/keepalived/keepalived.conf --dont-fork --log-console ${KEEPALIVED_COMMAND_LINE_ARGUMENTS}
