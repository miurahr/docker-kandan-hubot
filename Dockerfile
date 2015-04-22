FROM miurahr/rbenv:1.9.3-p551

MAINTAINER miurahr@linux.com

RUN mkdir -p /opt/kandan-hubot/cert
ADD install /opt/kandan-hubot/
RUN chmod 755 /opt/kandan-hubot/install
ADD build-config /opt/kandan-hubot/
RUN /opt/kandan-hubot/install

ADD init /opt/kandan-hubot
RUN chmod 755 /opt/kandan-hubot/init

EXPOSE 3000

VOLUME ["/var/log/app", "/opt/kandan-hubot/cert"]

WORKDIR /home/app
ENTRYPOINT ["/opt/kandan-hubot/init"]
CMD ["app:start"]
