FROM miurahr/rbenv:2.0.0-p643

MAINTAINER miurahr@linux.com

ADD install /opt/
RUN chmod 755 /opt/install
ADD build-config /opt/
RUN /opt/install

ADD init /opt/
RUN chmod 755 /opt/init

EXPOSE 3000

VOLUME ["/var/log/app"]

WORKDIR /home/app
ENTRYPOINT ["/opt/init"]
CMD ["app:start"]
