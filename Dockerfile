FROM quay.io/letsencrypt/letsencrypt:latest

MAINTAINER Christian Budde Christensen <budde377@gmail.com>

COPY crontab /etc/cron.d/letsencrypt
COPY entrypoint.sh .
COPY cron.sh .

RUN chmod 0644 /etc/cron.d/letsencrypt;\
    touch /var/log/cron.log

RUN mkdir /var/www

EXPOSE 80

ENTRYPOINT ["./entrypoint.sh"]
