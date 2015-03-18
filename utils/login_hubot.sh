#!/bin/bash

if [ -e /run/docker-kandan-hubot.pid ]; then
DPID=`cat /run/docker-kandan-hubot.pid`
else
DPID=`sudo docker ps -q -l`
fi

DADDRESS=`sudo docker port ${DPID} 22`
DPORT=${DADDRESS#0.0.0.0:}

if [ "${DPORT}" != "" ]; then
  ssh -p $DPORT -l hubot -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no localhost
else
  echo Error! Can not find docker guest ssh port.
  exit 1
fi
