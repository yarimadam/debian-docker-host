#!/usr/bin/env bash

cp /usr/share/zoneinfo/Europe/Istanbul /etc/localtime

apt-get update
apt-get upgrade -y

reboot
