# osixia/keepalived

[![](https://badge.imagelayers.io/osixia/keepalived:latest.svg)](https://imagelayers.io/?images=osixia/keepalived:latest 'Get your own badge on imagelayers.io')

A docker image to run Keepalived.
> [keepalived.org](http://keepalived.org/)

## Quick start

This image require the kernel module ip_vs loaded on the host and need to be run with : --privileged --net=host

    docker run --privileged --net=host -d osixia/keepalived
