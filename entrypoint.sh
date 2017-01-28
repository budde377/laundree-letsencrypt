#!/usr/bin/env bash
set -e
sed "s/{{HOSTS}}/\"$HOSTS\"/" cron.sh > cron-generated.sh
sed -i "s@{{TRIGGER}}@$TRIGGER@" cron-generated.sh

chmod +x cron-generated.sh
./cron-generated.sh no-renew

echo "Starting Cron"
cron
tail -f /var/log/cron.log
