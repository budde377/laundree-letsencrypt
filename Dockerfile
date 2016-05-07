FROM quay.io/letsencrypt/letsencrypt:latest

MAINTAINER Christian Budde Christensen <budde377@gmail.com>

ENV TRIGGER ""

COPY crontab /etc/cron.d/letsencrypt
COPY entrypoint.sh .
COPY cron.sh .

RUN apt-get update; \
    apt-get install -y curl

RUN chmod 0644 /etc/cron.d/letsencrypt;\
    touch /var/log/cron.log; \
    mkdir /var/www

VOLUME /var/certs

EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]
