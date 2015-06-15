#!/bin/bash -e
exec /usr/sbin/keepalived -f /etc/keepalived/keepalived.conf --dont-fork --log-console -D -d
