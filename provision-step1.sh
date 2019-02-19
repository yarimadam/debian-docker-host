#!/usr/bin/env bash

echo "LC_ALL=en_US.UTF-8" > /etc/default/locale

cp /usr/share/zoneinfo/Europe/Istanbul /etc/localtime

reboot
