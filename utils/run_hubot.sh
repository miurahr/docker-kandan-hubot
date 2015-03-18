#!/bin/sh
sudo docker run -d -p 22 -p 3000:3000 miurahr/kandan-hubot
DPID=`sudo docker ps -q -l`
echo $DPID > /run/kandan-hubot.pid
