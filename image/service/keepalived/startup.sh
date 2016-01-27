#!/bin/bash -e

# set -x (bash debug) if log level is trace
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/log-helper
log-helper level eq trace && set -x

FIRST_START_DONE="${CONTAINER_STATE_DIR}/docker-keepalived-first-start-done"
# container first start
if [ ! -e "$FIRST_START_DONE" ]; then

  #
  # bootstrap config
  #
  sed -i --follow-symlinks "s|{{ keepalived_interface }}|$KEEPALIVED_INTERFACE|g" ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf
  sed -i --follow-symlinks "s|{{ keepalived_priority }}|$KEEPALIVED_PRIORITY|g" ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf
  sed -i --follow-symlinks "s|{{ keepalived_password }}|$KEEPALIVED_PASSWORD|g" ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf

  if [ -n "$KEEPALIVED_NOTIFY" ]; then
    sed -i --follow-symlinks "s|{{ keepalived_notify }}|notify \"$KEEPALIVED_NOTIFY\"|g" ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf
    chmod +x $KEEPALIVED_NOTIFY
  else
    sed -i --follow-symlinks "/{{ keepalived_notify }}/d" ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf
  fi

  # unicast peers
  for peer in $(complex-bash-env iterate KEEPALIVED_UNICAST_PEERS)
  do
    sed -i --follow-symlinks "s|{{ keepalived_unicast_peers }}|${!peer}\n    {{ keepalived_unicast_peers }}|g" ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf
  done
  sed -i --follow-symlinks "/{{ keepalived_unicast_peers }}/d" ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf

  # virtual ips
  for vip in $(complex-bash-env iterate KEEPALIVED_VIRTUAL_IPS)
  do
    sed -i --follow-symlinks "s|{{ keepalived_virtual_ips }}|${!vip}\n    {{ keepalived_virtual_ips }}|g" ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf
  done
  sed -i --follow-symlinks "/{{ keepalived_virtual_ips }}/d" ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf

  touch $FIRST_START_DONE
fi

if [ ! -e "/etc/backup-manager.conf" ]; then
  ln -sf ${CONTAINER_SERVICE_DIR}/keepalived/assets/keepalived.conf /etc/keepalived/keepalived.conf
fi

exit 0
