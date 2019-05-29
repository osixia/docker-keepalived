# osixia/keepalived

[![Docker Pulls](https://img.shields.io/docker/pulls/osixia/keepalived.svg)][hub]
[![Docker Stars](https://img.shields.io/docker/stars/osixia/keepalived.svg)][hub]
[![](https://images.microbadger.com/badges/image/osixia/keepalived.svg)](http://microbadger.com/images/osixia/keepalived "Get your own image badge on microbadger.com")

[hub]: https://hub.docker.com/r/osixia/keepalived/

Latest release: 2.0.16 - Keepalived 2.0.16 - [Changelog](CHANGELOG.md) | [Docker Hub](https://hub.docker.com/r/osixia/keepalived/) 

**A docker image to run Keepalived.**
> [keepalived.org](http://keepalived.org/)

- [osixia/keepalived](#osixiakeepalived)
	- [Quick start](#quick-start)
	- [Beginner Guide](#beginner-guide)
		- [Use your own Keepalived config](#use-your-own-keepalived-config)
		- [Fix docker mounted file problems](#fix-docker-mounted-file-problems)
		- [Debug](#debug)
	- [Environment Variables](#environment-variables)
		- [Set your own environment variables](#set-your-own-environment-variables)
			- [Use command line argument](#use-command-line-argument)
			- [Link environment file](#link-environment-file)
			- [Make your own image or extend this image](#make-your-own-image-or-extend-this-image)
	- [Advanced User Guide](#advanced-user-guide)
		- [Extend osixia/keepalived:2.0.16 image](#extend-osixiakeepalived2016-image)
		- [Make your own keepalived image](#make-your-own-keepalived-image)
		- [Tests](#tests)
		- [Under the hood: osixia/light-baseimage](#under-the-hood-osixialight-baseimage)
	- [Security](#security)
	- [Changelog](#changelog)

## Quick start

This image require the kernel module ip_vs loaded on the host (`modprobe ip_vs`) and need to be run with : --cap-add=NET_ADMIN --net=host

    docker run --cap-add=NET_ADMIN --cap-add=NET_BROADCAST --cap-add=NET_RAW --net=host -d osixia/keepalived:2.0.16

## Beginner Guide

### Use your own Keepalived config
This image comes with a keepalived config file that can be easily customized via environment variables for a quick bootstrap,
but setting your own keepalived.conf is possible. 2 options:

- Link your config file at run time to `/container/service/keepalived/assets/keepalived.conf` :

      docker run --volume /data/my-keepalived.conf:/container/service/keepalived/assets/keepalived.conf --detach osixia/keepalived:2.0.16

- Add your config file by extending or cloning this image, please refer to the [Advanced User Guide](#advanced-user-guide)

### Fix docker mounted file problems

You may have some problems with mounted files on some systems. The startup script try to make some file adjustment and fix files owner and permissions, this can result in multiple errors. See [Docker documentation](https://docs.docker.com/v1.4/userguide/dockervolumes/#mount-a-host-file-as-a-data-volume).

To fix that run the container with `--copy-service` argument :

		docker run [your options] osixia/keepalived:2.0.16 --copy-service

### Debug

The container default log level is **info**.
Available levels are: `none`, `error`, `warning`, `info`, `debug` and `trace`.

Example command to run the container in `debug` mode:

	docker run --detach osixia/keepalived:2.0.16 --loglevel debug

See all command line options:

	docker run osixia/keepalived:2.0.16 --help


## Environment Variables

Environment variables defaults are set in **image/environment/default.yaml**

See how to [set your own environment variables](#set-your-own-environment-variables)


- **KEEPALIVED_INTERFACE**: Keepalived network interface. Defaults to `eth0`
- **KEEPALIVED_PASSWORD**: Keepalived password. Defaults to `d0cker`
- **KEEPALIVED_PRIORITY** Keepalived node priority. Defaults to `150`
- **KEEPALIVED_ROUTER_ID** Keepalived virtual router ID. Defaults to `51`

- **KEEPALIVED_UNICAST_PEERS** Keepalived unicast peers. Defaults to :
      - 192.168.1.10
      - 192.168.1.11

  If you want to set this variable at docker run command add the tag `#PYTHON2BASH:` and convert the yaml in python:

      docker run --env KEEPALIVED_UNICAST_PEERS="#PYTHON2BASH:['192.168.1.10', '192.168.1.11']" --detach osixia/keepalived:2.0.16

  To convert yaml to python online : http://yaml-online-parser.appspot.com/


- **KEEPALIVED_VIRTUAL_IPS** Keepalived virtual IPs. Defaults to :

      - 192.168.1.231
      - 192.168.1.232

  If you want to set this variable at docker run command convert the yaml in python, see above.

- **KEEPALIVED_NOTIFY** Script to execute when node state change. Defaults to `/container/service/keepalived/assets/notify.sh`

- **KEEPALIVED_COMMAND_LINE_ARGUMENTS** Keepalived command line arguments; Defaults to `--log-detail --dump-conf`

- **KEEPALIVED_STATE** The starting state of keepalived; it can either be MASTER or BACKUP.

### Set your own environment variables

#### Use command line argument
Environment variables can be set by adding the --env argument in the command line, for example:

    docker run --env KEEPALIVED_INTERFACE="eno1" --env KEEPALIVED_PASSWORD="password!" \
    --env KEEPALIVED_PRIORITY="100" --detach osixia/keepalived:2.0.16


#### Link environment file

For example if your environment file is in :  /data/environment/my-env.yaml

	docker run --volume /data/environment/my-env.yaml:/container/environment/01-custom/env.yaml \
	--detach osixia/keepalived:2.0.16

Take care to link your environment file to `/container/environment/XX-somedir` (with XX < 99 so they will be processed before default environment files) and not  directly to `/container/environment` because this directory contains predefined baseimage environment files to fix container environment (INITRD, LANG, LANGUAGE and LC_CTYPE).

#### Make your own image or extend this image

This is the best solution if you have a private registry. Please refer to the [Advanced User Guide](#advanced-user-guide) just below.

## Advanced User Guide

### Extend osixia/keepalived:2.0.16 image

If you need to add your custom TLS certificate, bootstrap config or environment files the easiest way is to extends this image.

Dockerfile example:

    FROM osixia/keepalived:2.0.16
    MAINTAINER Your Name <your@name.com>

    ADD keepalived.conf /container/service/keepalived/assets/keepalived.conf
    ADD environment /container/environment/01-custom
    ADD scripts.sh /container/service/keepalived/assets/notify.sh


### Make your own keepalived image


Clone this project :

	git clone https://github.com/osixia/docker-keepalived
	cd docker-keepalived

Adapt Makefile, set your image NAME and VERSION, for example :

	NAME = osixia/keepalived
	VERSION = 1.3.5

	becomes :
	NAME = billy-the-king/keepalived
	VERSION = 0.1.0

Add your custom scripts, environment files, config ...

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

## Security
If you discover a security vulnerability within this docker image, please send an email to the Osixia! team at security@osixia.net. For minor vulnerabilities feel free to add an issue here on github.

Please include as many details as possible.

## Changelog

Please refer to: [CHANGELOG.md](CHANGELOG.md)
