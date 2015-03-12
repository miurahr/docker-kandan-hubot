#!/bin/sh

KANDAN_MODE=${MODE:-'development'}

case $KANDAN_MODE in
  'production')
    sed -ri "s/database: kandan/database: ${DBNAME}/g" /home/hubot/kandan/config/database.yml
    sed -ri "s/host: localhost/host: ${DBHOST}/g" /home/hubot/kandan/config/database.yml
    sed -ri "s/username: kandan/username: ${DBUSER}/g" /home/hubot/kandan/config/database.yml
    sed -ri "s/password: something/username: ${DBPASS}/g" /home/hubot/kandan/config/database.yml
    export RAILS_ENV=production
    ;;
  'development')
    export RAILS_ENV=development
    ;;
  'test')
    export RAILS_ENV=test
    ;;
  default)
    exit 1
    ;;
esac

bundle exec rake db:create db:migrate kandan:bootstrap
bundle exec rake assets:precompile
bundle exec rake kandan:boot_hubot
bundle exec rake kandan:hubot_access_key | awk '{print $6}' > hubot-key
sudo awk '{print "export HUBOT_KANDAN_TOKEN="$0}' /home/hubot/kandan/hubot-key >> /etc/profile.d/hubot.sh 
sudo awk '{print " HUBOT_KANDAN_TOKEN="$0}' /home/hubot/kandan/hubot-key >> /etc/supervisor/conf.d/hubot.conf 

sudo sed -ri "s/command=bundle exec thin start -e production/command=bundle exec thin start -e ${KANDAN_MODE}/g" /etc/supervisor/conf.d/kandan.conf
supervisord -n
