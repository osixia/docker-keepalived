#!/bin/bash -e

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
    fi
  fi

  touch $FIRST_START_DONE
fi

exit 0
