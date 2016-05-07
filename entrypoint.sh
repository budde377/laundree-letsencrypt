#!/usr/bin/env bash

sed "s@{{TRIGGER}}@$TRIGGER@" cron.sh > cron-generated.sh

chmod +x cron-generated.sh
./cron-generated.sh no-renew

echo "Starting Cron"
cron
tail -f /var/log/cron.log
