FROM quay.io/letsencrypt/letsencrypt:latest

MAINTAINER Christian Budde Christensen <budde377@gmail.com>

COPY crontab /etc/cron.d/letsencrypt
COPY entrypoint.sh .

RUN apt-get update;\
    apt-get install cron

RUN chmod 0644 /etc/cron.d/letsencrypt;\
    touch /var/log/cron.log

ENTRYPOINT ["./entrypoint.sh"]
