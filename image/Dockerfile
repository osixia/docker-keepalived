FROM osixia/light-baseimage:0.1.0
MAINTAINER Bertrand Gouny <bertrand.gouny@osixia.net>

# Keepalived version
ENV KEEPALIVED_VERSION 1.2.19

# Use baseimage-docker's init system.
CMD ["/osixia/tool/run"]

# Install Keepalived
RUN apt-get -y update \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y \
    curl make gcc pkg-config libssl-dev libnl-3-dev libnl-genl-3-dev \
    && curl -o keepalived.tar.gz -SL http://keepalived.org/software/keepalived-${KEEPALIVED_VERSION}.tar.gz \
    && mkdir -p /osixia/keepalived-sources \
    && tar -xzf keepalived.tar.gz --strip 1 -C /osixia/keepalived-sources \
    && cd osixia/keepalived-sources \
    && ./configure --with-kernel-dir=/lib/modules/$(uname -r)/build \
    && make && make install \
    && cd - && mkdir -p /etc/keepalived \
    && apt-get remove -y --purge --auto-remove curl make gcc pkg-config libssl-dev

# Add service directory to /osixia/service
ADD service /osixia/service

# Clean all
# Use baseimage install-service script and clean all
RUN ./sbin/install-service \
  && rm -f keepalived.tar.gz && rm -rf /osixia/keepalived-sources \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add default env variables
ADD env.yaml /etc/env.yaml
