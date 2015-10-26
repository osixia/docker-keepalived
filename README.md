# osixia/keepalived

[![](https://badge.imagelayers.io/osixia/keepalived:latest.svg)](https://imagelayers.io/?images=osixia/keepalived:latest 'Get your own badge on imagelayers.io')

A docker image to run Keepalived.
> [keepalived.org](http://keepalived.org/)

## Quick start

This image require the kernel module ip_vs loaded on the host (`modprobe ip_vs`) and need to be run with : --cap-add=NET_ADMIN --net=host

    docker run --cap-add=NET_ADMIN --net=host -d osixia/keepalived

## Environment Variables

Environement variables defaults are set in **image/env.yaml**. You can modify environment variable values directly in this file and rebuild the image ([see manual build](#manual-build)). You can also override those values at run time with -e argument or by setting your own env.yaml file as a docker volume to `/container/environment/env.yaml`. See examples below.

- **KEEPALIVED_INTERFACE**: Keepalived network interface. Defaults to `eth0`
- **KEEPALIVED_PASSWORD**: Keepalived password. Defaults to `d0cker`
- **KEEPALIVED_PRIORITY** Keepalived node priority. Defaults to `150`

- **KEEPALIVED_UNICAST_PEERS** Keepalived unicast peers. Defaults to :
      - 192.168.1.10
      - 192.168.1.11

    If you want to set this variable at docker run command convert the yaml in python :

      docker run -e KEEPALIVED_UNICAST_PEERS="[192.168.1.10', '192.168.1.11']" -d osixia/phpldapadmin

  To convert yaml to python online : http://yaml-online-parser.appspot.com/


- **KEEPALIVED_VIRTUAL_IPS** Add a read only user. Defaults to :

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

## Manual build

Clone this project :

	git clone https://github.com/osixia/docker-keepalived
	cd docker-keepalived

Adapt Makefile, set your image NAME and VERSION, for example :

	NAME = osixia/keepalived
	VERSION = 0.1.6

	becomes :
	NAME = billy-the-king/keepalived
	VERSION = 0.1.0

Build your image :

	make build

Run your image :

	docker run -d billy-the-king/keepalived:0.1.0

## Tests

We use **Bats** (Bash Automated Testing System) to test this image:

> [https://github.com/sstephenson/bats](https://github.com/sstephenson/bats)

Install Bats, and in this project directory run :

	make test
