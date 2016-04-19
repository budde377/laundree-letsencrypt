#!/usr/bin/env bash

cron

watch -t -n 60 cat /var/log/cron.log
