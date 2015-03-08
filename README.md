docker-kandan-hubot
===================
Dockerfile to build image which is installed Kandan and hubot.  
Here is a fork version of 
blog: http://hidemium.hatenablog.com/entry/2014/11/03/022453

## Usage

```
$ sudo docker pull miurahr/kandan-hubot
$ sudo docker run -d -p 22 -p 3000:3000 miurahr/kandan-hubot
```

## Contents

The image contains:

- Kandan miurahr/kandan/i18n branch
- hubot 2.6.0
- hubot-kandan adapter 1.1.0

## References

  * https://github.com/github/hubot
  * https://github.com/kandanapp/kandan
  * https://github.com/kandanapp/hubot-kandan
