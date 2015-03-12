FROM ubuntu:14.04.2

MAINTAINER miurahr

# install basic package
ADD sources.list /etc/apt/sources.list
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install \
    openssh-server \
    supervisor \
    build-essential \
    curl \
    unzip \
    git-core \
    ruby1.9.1-dev \
    ruby-bundler \
    libxslt-dev \
    libxml2-dev \
    libpq-dev \
    libsqlite3-dev \
    gcc \
    g++ \
    make && \
    curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

# install sshd
RUN mkdir -p /root/.ssh /var/run/sshd && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config

# root/hubot user
RUN useradd -m -s /bin/bash hubot  && \
    echo 'hubot:hubot' | chpasswd && \
    echo 'hubot ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/hubot && \
    echo 'root:root' | chpasswd
ENV HOME /home/hubot

# install Kandan
USER hubot
WORKDIR /home/hubot
RUN git clone https://github.com/miurahr/kandan.git && \
    echo 'gem: --no-rdoc --no-ri' >> /home/hubot/.gemrc
WORKDIR /home/hubot/kandan
RUN git checkout i18n && \
    sudo gem install execjs && bundle install
ADD kandan/database.yml /home/hubot/kandan/config/database.yml
RUN sed -ri 's/config.serve_static_assets = false/config.serve_static_assets = true/g' \
    /home/hubot/kandan/config/environments/production.rb && \

# install Hubot
WORKDIR /home/hubot
RUN wget https://github.com/github/hubot/archive/v2.6.0.zip && unzip v2.6.0.zip && rm v2.6.0.zip && mv hubot-2.6.0 hubot-root

WORKDIR /home/hubot/hubot-root
RUN mkdir -p hubot/bin 
ADD hubot/package.json /home/hubot/hubot-root/hubot/package.json
ADD hubot/hubot-scripts.json /home/hubot/hubot-root/hubot/hubot-scripts.json
RUN sudo npm install -g mime@1.2.4 qs@0.4.2 && sudo npm install && sudo make package

WORKDIR /home/hubot/hubot-root/hubot
RUN git clone https://github.com/miurahr/hubot-kandan.git node_modules/hubot-kandan && \
    npm install faye && npm install ntwitter

USER root
ADD hubot/hubot.sh /etc/profile.d/hubot.sh

# add supervisor config file 
RUN mkdir -p /var/log/supervisor /etc/supervisor/conf.d
ADD sshd.conf /etc/supervisor/conf.d/sshd.conf
ADD kandan/kandan.conf /etc/supervisor/conf.d/kandan.conf
ADD hubot/hubot.conf /etc/supervisor/conf.d/hubot.conf
ADD runner.sh /usr/bin/runner.sh
RUN chmod +x /usr/bin/runner.sh

# expose ports
EXPOSE 22 3000

# define default command
CMD /usr/bin/runner.sh
