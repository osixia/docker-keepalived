#!/bin/bash -ex

FIRST_START_DONE="/etc/docker-keepalived-first-start-done"

# container first start
if [ ! -e "$FIRST_START_DONE" ]; then

  # config folder is empty use bootstrap config if available
  if [ ! -e /etc/keepalived/keepalived.conf ]; then
    echo "No keepalived.conf provided using image default one"
    if [ ! -e /osixia/keepalived/keepalived.conf ]; then
      echo "Error: No default keepalived.conf found in /osixia/keepalived/keepalived.conf"
      exit 1
    else
      ln -s /osixia/keepalived/keepalived.conf /etc/keepalived/keepalived.conf

      #
      # bootstrap config
      #
      sed -i "s|{{ keepalived_interface }}|$KEEPALIVED_INTERFACE|g" /etc/keepalived/keepalived.conf
      sed -i "s|{{ keepalived_priority }}|$KEEPALIVED_PRIORITY|g" /etc/keepalived/keepalived.conf
      sed -i "s|{{ keepalived_password }}|$KEEPALIVED_PASSWORD|g" /etc/keepalived/keepalived.conf

      # unicast peers
      KEEPALIVED_UNICAST_PEERS=($KEEPALIVED_UNICAST_PEERS)
      for peer in "${KEEPALIVED_UNICAST_PEERS[@]}"
      do
        # it's just a peer
        # stored in a variable
        if [ -n "${!peer}" ]; then
          sed -i "s|{{ peer_ip }}|${!peer}\n    {{ peer_ip }}|g" /etc/keepalived/keepalived.conf
        # directly
        else
          sed -i "s|{{ peer_ip }}|${peer}\n    {{ peer_ip }}|g" /etc/keepalived/keepalived.conf
        fi
      done
      sed -i "/{{ peer_ip }}/d" /etc/keepalived/keepalived.conf

      # virtual ips
      KEEPALIVED_VIRTUAL_IPS=($KEEPALIVED_VIRTUAL_IPS)
      for vip in "${KEEPALIVED_VIRTUAL_IPS[@]}"
      do
        # it's just a peer
        # stored in a variable
        if [ -n "${!vip}" ]; then
          sed -i "s|{{ floating_ip }}|${!vip}\n    {{ floating_ip }}|g" /etc/keepalived/keepalived.conf
        # directly
        else
          sed -i "s|{{ floating_ip }}|${vip}\n    {{ floating_ip }}|g" /etc/keepalived/keepalived.conf
        fi
      done
      sed -i "/{{ floating_ip }}/d" /etc/keepalived/keepalived.conf
    fi
  fi

  touch $FIRST_START_DONE
fi

exit 0
