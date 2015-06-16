#!/bin/bash -e
exec /usr/local/sbin/keepalived -f /etc/keepalived/keepalived.conf --dont-fork --log-console -D -d
