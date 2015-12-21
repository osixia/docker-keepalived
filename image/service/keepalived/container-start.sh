#!/bin/bash -e

FIRST_START_DONE="/etc/docker-keepalived-first-start-done"

# container first start
if [ ! -e "$FIRST_START_DONE" ]; then

  ln -s /container/service/keepalived/assets/keepalived.conf /etc/keepalived/keepalived.conf

  #
  # bootstrap config
  #
  sed -i --follow-symlinks --follow-symlinks "s|{{ keepalived_interface }}|$KEEPALIVED_INTERFACE|g" /etc/keepalived/keepalived.conf
  sed -i --follow-symlinks --follow-symlinks "s|{{ keepalived_priority }}|$KEEPALIVED_PRIORITY|g" /etc/keepalived/keepalived.conf
  sed -i --follow-symlinks --follow-symlinks "s|{{ keepalived_password }}|$KEEPALIVED_PASSWORD|g" /etc/keepalived/keepalived.conf

  if [ -n "$KEEPALIVED_NOTIFY" ]; then
    sed -i --follow-symlinks --follow-symlinks "s|{{ keepalived_notify }}|notify \"$KEEPALIVED_NOTIFY\"|g" /etc/keepalived/keepalived.conf
    chmod +x $KEEPALIVED_NOTIFY
  else
    sed -i --follow-symlinks --follow-symlinks "/{{ keepalived_notify }}/d" /etc/keepalived/keepalived.conf
  fi

  # unicast peers
  KEEPALIVED_UNICAST_PEERS=($KEEPALIVED_UNICAST_PEERS)
  for peer in "${KEEPALIVED_UNICAST_PEERS[@]}"
  do
    # it's just a peer
    # stored in a variable
    if [ -n "${!peer}" ]; then
      sed -i --follow-symlinks --follow-symlinks "s|{{ keepalived_unicast_peers }}|${!peer}\n    {{ keepalived_unicast_peers }}|g" /etc/keepalived/keepalived.conf
    # directly
    else
      sed -i --follow-symlinks --follow-symlinks "s|{{ keepalived_unicast_peers }}|${peer}\n    {{ keepalived_unicast_peers }}|g" /etc/keepalived/keepalived.conf
    fi
  done
  sed -i --follow-symlinks --follow-symlinks "/{{ keepalived_unicast_peers }}/d" /etc/keepalived/keepalived.conf

  # virtual ips
  KEEPALIVED_VIRTUAL_IPS=($KEEPALIVED_VIRTUAL_IPS)
  for vip in "${KEEPALIVED_VIRTUAL_IPS[@]}"
  do
    # it's just a peer
    # stored in a variable
    if [ -n "${!vip}" ]; then
      sed -i --follow-symlinks --follow-symlinks "s|{{ keepalived_virtual_ips }}|${!vip}\n    {{ keepalived_virtual_ips }}|g" /etc/keepalived/keepalived.conf
    # directly
    else
      sed -i --follow-symlinks --follow-symlinks "s|{{ keepalived_virtual_ips }}|${vip}\n    {{ keepalived_virtual_ips }}|g" /etc/keepalived/keepalived.conf
    fi
  done
  sed -i --follow-symlinks --follow-symlinks "/{{ keepalived_virtual_ips }}/d" /etc/keepalived/keepalived.conf

  touch $FIRST_START_DONE
fi

exit 0
