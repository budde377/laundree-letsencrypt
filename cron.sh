#!/usr/bin/env bash

source /opt/certbot/venv/bin/activate

TRIGGER = {{TRIGGER}}

cd /var/www
python -m SimpleHTTPServer 80 &

if [ $# -eq 0 ]
then certbot renew
else certbot certonly --webroot -w /var/www/ --agree-tos --email budde@laundree.io -d laundree.io
fi

cat /etc/letsencrypt/live/laundree.io/fullchain.pem /etc/letsencrypt/live/laundree.io/privkey.pem > /var/certs/haproxy.pem

kill %%

if [ -n "$TRIGGER" ]
    then
        curl -X POST "$TRIGGER"
fi
