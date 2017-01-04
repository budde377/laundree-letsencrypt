#!/usr/bin/env bash

sed "s/{{HOST}}/$HOST/" cron.sh > cron-generated.sh
sed -i "s@{{TRIGGER}}@$TRIGGER@" cron-generated.sh

chmod +x cron-generated.sh
./cron-generated.sh no-renew

echo "Starting Cron"
cron
tail -f /var/log/cron.log
