#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

exec /usr/local/sbin/keepalived -f /usr/local/etc/keepalived/keepalived.conf --dont-fork --log-console ${KEEPALIVED_COMMAND_LINE_ARGUMENTS}
