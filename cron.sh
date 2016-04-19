#!/usr/bin/env bash

source /opt/certbot/venv/bin/activate

cd /var/www
python -m SimpleHTTPServer 80 &

certbot certonly --webroot -w /var/www/ --agree-tos --email budde377@gmail.com -d laundree.io

cat /etc/letsencrypt/live/laundree.io/fullchain.pem /etc/letsencrypt/live/laundree.io/privkey.pem > /var/certs/haproxy.pem

kill %%
