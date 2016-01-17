#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

exec /usr/local/sbin/keepalived -f /etc/keepalived/keepalived.conf --dont-fork --log-console -D -d
