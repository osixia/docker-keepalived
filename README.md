# osixia/keepalived

[![](https://badge.imagelayers.io/osixia/keepalived:latest.svg)](https://imagelayers.io/?images=osixia/keepalived:latest 'Get your own badge on imagelayers.io') | Latest release: 0.2.0 - [Changelog](CHANGELOG.md) | [Docker Hub](https://hub.docker.com/r/osixia/keepalived/) 

A docker image to run Keepalived.
> [keepalived.org](http://keepalived.org/)

## Quick start

This image require the kernel module ip_vs loaded on the host (`modprobe ip_vs`) and need to be run with : --cap-add=NET_ADMIN --net=host

    docker run --cap-add=NET_ADMIN --net=host -d osixia/keepalived:0.2.0

## Environment Variables

Environment variables defaults are set in **image/environment/default.yaml**

See how to [set your own environment variables](#set-your-own-environment-variables)


- **KEEPALIVED_INTERFACE**: Keepalived network interface. Defaults to `eth0`
- **KEEPALIVED_PASSWORD**: Keepalived password. Defaults to `d0cker`
- **KEEPALIVED_PRIORITY** Keepalived node priority. Defaults to `150`

- **KEEPALIVED_UNICAST_PEERS** Keepalived unicast peers. Defaults to :
      - 192.168.1.10
      - 192.168.1.11

  If you want to set this variable at docker run command add the tag `#PYTHON2BASH:` and convert the yaml in python:

      docker run --env KEEPALIVED_UNICAST_PEERS="#PYTHON2BASH:['192.168.1.10', '192.168.1.11']" --detach osixia/keepalived:0.2.0

  To convert yaml to python online : http://yaml-online-parser.appspot.com/


- **KEEPALIVED_VIRTUAL_IPS** Keepalived virtual IPs. Defaults to :

      - 192.168.1.231
      - 192.168.1.232

  If you want to set this variable at docker run command convert the yaml in python, see above.

- **KEEPALIVED_NOTIFY** Script to execute when node state change. Defaults to `/container/service/keepalived/assets/notify.sh`

### Set environment variables at run time :

Environment variable can be set directly by adding the -e argument in the command line, for example :

	docker run -e KEEPALIVED_INTERFACE="eno1" -e KEEPALIVED_PASSWORD="password!" \
	-e KEEPALIVED_PRIORITY="100" -d osixia/keepalived

Or by setting your own `env.yaml` file as a docker volume to `/container/environment/env.yaml`

	docker run -v /data/my-env.yaml:/container/environment/env.yaml \
	-d osixia/keepalived

### Set your own environment variables

#### Use command line argument
Environment variables can be set by adding the --env argument in the command line, for example:

    docker run --env KEEPALIVED_INTERFACE="eno1" --env KEEPALIVED_PASSWORD="password!" \
    --env KEEPALIVED_PRIORITY="100" --detach osixia/keepalived:0.2.0


#### Link environment file

For example if your environment file is in :  /data/environment/my-env.yaml

	docker run --volume /data/environment/my-env.yaml:/container/environment/01-custom/env.yaml \
	--detach osixia/keepalived:0.2.0

Take care to link your environment file to `/container/environment/XX-somedir` (with XX < 99 so they will be processed before default environment files) and not  directly to `/container/environment` because this directory contains predefined baseimage environment files to fix container environment (INITRD, LANG, LANGUAGE and LC_CTYPE).

#### Make your own image or extend this image

This is the best solution if you have a private registry. Please refer to the [Advanced User Guide](#advanced-user-guide) just below.

## Advanced User Guide

### Extend osixia/keepalived:0.2.0 image

If you need to add your custom TLS certificate, bootstrap config or environment files the easiest way is to extends this image.

Dockerfile example:

    FROM osixia/osixia/keepalived:0.2.0
    MAINTAINER Your Name <your@name.com>

    ADD environment /container/environment/01-custom
    ADD scripts.sh /container/service/keepalived/assets/notify.sh


### Make your own keepalived image


Clone this project :

	git clone https://github.com/osixia/docker-keepalived
	cd docker-keepalived

Adapt Makefile, set your image NAME and VERSION, for example :

	NAME = osixia/keepalived
	VERSION = 0.2.0

	becomes :
	NAME = billy-the-king/keepalived
	VERSION = 0.1.0

Build your image :

	make build

Run your image :

	docker run -d billy-the-king/keepalived:0.1.0

### Tests

We use **Bats** (Bash Automated Testing System) to test this image:

> [https://github.com/sstephenson/bats](https://github.com/sstephenson/bats)

Install Bats, and in this project directory run :

	make test


### Under the hood: osixia/light-baseimage

This image is based on osixia/light-baseimage.
More info: https://github.com/osixia/docker-light-baseimage

## Changelog

Please refer to: [CHANGELOG.md](CHANGELOG.md)
