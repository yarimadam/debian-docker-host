#!/usr/bin/env bash

cp /usr/share/zoneinfo/Europe/Istanbul /etc/localtime

aptitude update
aptitude upgrade -y

reboot
