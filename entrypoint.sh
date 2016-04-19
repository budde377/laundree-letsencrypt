#!/usr/bin/env bash

./cron.sh

echo "Starting Cron"
cron
tail -f /var/log/cron.log
