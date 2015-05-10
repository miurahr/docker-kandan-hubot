docker-kandan-hubot
=====================

[![Join the chat at https://gitter.im/miurahr/docker-kandan-hubot](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/miurahr/docker-kandan-hubot?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Run kandan and hubot on Docker.

## Images

* miurahr/kandan-hubot:stable  

  based on kandan v1.2 and hubot 2.4.7, stable build
  status: work fine

* miurahr/kandan-hubot:latest

  based on kandan and hubot master branch
  status: under development

## Build docker image

```
$ git clone https://github.com/miurahr/docker-kandan-hubot.git
$ cd docker-kandan-hubot
$ docker-compose build .
```

## Usage

Provisionings are placed in docker-compose.yml.
Please edit it before start.


```
$ cp docker-compose.yml.sample-postgresql-docker
$ vi docker-compose.yml
$ sudo mkdir /var/log/kandan-hubot
$ docker-compose up -d
```

## Debug

Examine log file in `/var/log/kandan-hubot/`

Or log in to running image like;

```
$ docker ps -a
$ docker exec -t -i dockerkandan_Kandanhubot_1 /bin/bash
# cat /var/log/app/kandan.log
```

