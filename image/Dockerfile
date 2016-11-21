# Use osixia/light-baseimage
# sources: https://github.com/osixia/docker-light-baseimage
FROM osixia/light-baseimage:0.2.6
MAINTAINER Bertrand Gouny <bertrand.gouny@osixia.net>

# Keepalived version
ENV KEEPALIVED_VERSION 1.3.0

# Download, build and install Keepalived
RUN apt-get -y update \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       curl \
       gcc \
       libnl-3-dev \
       libnl-route-3-dev \
       libnl-genl-3-dev \
       libssl-dev \
       make \
       pkg-config \
    && curl -o keepalived.tar.gz -SL http://keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz \
    && mkdir -p /container/keepalived-sources \
    && tar -xzf keepalived.tar.gz --strip 1 -C /container/keepalived-sources \
    && cd container/keepalived-sources \
    && ./configure --with-kernel-dir=/lib/modules/$(uname -r)/build \
    && make && make install \
    && cd - && mkdir -p /etc/keepalived \
    && apt-get remove -y --purge --auto-remove curl make gcc pkg-config libssl-dev \
    && rm -f keepalived.tar.gz \
    && rm -rf /container/keepalived-sources \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add service directory to /container/service
ADD service /container/service

# Use baseimage install-service script
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/install-service
RUN /container/tool/install-service

# Add default env variables
ADD environment /container/environment/99-default
