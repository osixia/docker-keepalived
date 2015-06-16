#!/bin/bash

TYPE=$1
NAME=$2
STATE=$3

case $STATE in
        "MASTER") echo "I'm the MASTER! Whup whup."
                  exit 0
                  ;;
        "BACKUP") "Ok, i'm just a backup, great."
                  exit 0
                  ;;
        "FAULT")  echo "Fault, what ?"
                  exit 0
                  ;;
        *)        echo "Unknown state"
                  exit 1
                  ;;
esac
