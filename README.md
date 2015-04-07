docker-kandan-hubot
=====================

Run kandan and hubot on Docker.

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

