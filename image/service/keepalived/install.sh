#!/bin/bash -e
# this script is run during the image build

# delete keepalived default config file
rm /usr/local/etc/keepalived/keepalived.conf
