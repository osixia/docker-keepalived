FROM osixia/baseimage:0.10.4
MAINTAINER Bertrand Gouny <bertrand.gouny@osixia.net>

# This container need run options :
# --privileged=true
# --net=host
# -v /lib/modules:/lib/modules

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install Keepalived
RUN apt-get -y update \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    keepalived

# Add Keepalived assets
ADD service/keepalived/assets /osixia/keepalived

# Run clean all
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add default env variables
ADD env.yml /etc/env.yml

# Add Keepalived container start config & daemon
ADD service/keepalived/container-start.sh /etc/my_init.d/keepalived
ADD service/keepalived/daemon.sh /etc/service/keepalived/run
