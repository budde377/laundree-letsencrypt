#!/usr/bin/env bash

source /opt/certbot/venv/bin/activate

TRIGGER={{TRIGGER}}
HOSTS={{HOSTS}}

cd /var/www

echo "Starting server"
python -m SimpleHTTPServer 80 &

sleep 10

IFS=';' read -ra HOSTA <<< "$HOSTS"
if [ $# -eq 0 ]; then
  certbot renew
fi

for host in "${HOSTA[@]}"; do
  if [ $# -eq 0 ]; then
    echo "Not fetching cert"
  else
    certbot certonly --force-renewal --webroot -w /var/www/ --agree-tos --email budde@laundree.io -d "$host"
  fi
  fileFullChain="/etc/letsencrypt/live/$host/fullchain.pem"
  filePrivateKey="/etc/letsencrypt/live/$host/privkey.pem"
  if [[ -f $fileFullChain && -f $filePrivateKey ]]; then
    echo "Moving certificate"
    cat ${fileFullChain} ${filePrivateKey} > "/var/certs/$host.pem"
  else
    echo "Certificates files not found. Will not move."
  fi
done
 

echo "Killing server"
kill %%

if [ -n "$TRIGGER" ]; then
  echo "Triggering"
  curl -X POST "$TRIGGER"
fi
