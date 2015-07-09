FROM osixia/baseimage:0.10.4
MAINTAINER Bertrand Gouny <bertrand.gouny@osixia.net>

# Keepalived version
ENV KEEPALIVED_VERSION 1.2.19

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install Keepalived
RUN apt-get -y update \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y \
    make gcc pkg-config libssl-dev libnl-dev \
    && curl -o keepalived.tar.gz -SL http://keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz \
    && mkdir -p /osixia/keepalived-sources \
    && tar -xzf keepalived.tar.gz --strip 1 -C /osixia/keepalived-sources \
    && cd osixia/keepalived-sources \
    && ./configure --with-kernel-dir=/lib/modules/$(uname -r)/build \
    && make && make install \
    && cd - && mkdir -p /etc/keepalived \
    && apt-get remove -y --purge --auto-remove make gcc pkg-config libssl-dev

# Add Keepalived assets
ADD service/keepalived/assets /osixia/keepalived

# Clean all
RUN rm keepalived.tar.gz \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add default env variables
ADD env.yml /etc/env.yml

# Add Keepalived container start config & daemon
ADD service/keepalived/container-start.sh /etc/my_init.d/keepalived
ADD service/keepalived/daemon.sh /etc/service/keepalived/run
