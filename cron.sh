#!/usr/bin/env bash

source /opt/certbot/venv/bin/activate
set -e
TRIGGER={{TRIGGER}}
HOST={{HOST}}

cd /var/www
python -m SimpleHTTPServer 80 &

if [ $# -eq 0 ]
then certbot renew
else certbot certonly --webroot -w /var/www/ --agree-tos --email budde@laundree.io -d "$HOST"
fi

cat "/etc/letsencrypt/live/$HOST/fullchain.pem" "/etc/letsencrypt/live/$HOST/privkey.pem" > "/var/certs/$HOST.pem"

kill %%

if [ -n "$TRIGGER" ]
    then
        curl -X POST "$TRIGGER"
fi
