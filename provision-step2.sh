#!/usr/bin/env bash

apt-get install -y \
   git \
   certbot \
   apache2-utils \
   openjdk-8-jdk

# docker pre-requisite
apt-get install -y \
   apt-transport-https \
   ca-certificates \
   curl \
   gnupg2 \
   software-properties-common

# add docker gpg key
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -

# add docker repository
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"

aptitude update && aptitude install -y docker-ce docker-ce-cli containerd.io

curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

useradd --shell /bin/bash --create-home yarimadam

echo "yarimadam ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/yarimadam

usermod -aG sudo yarimadam
usermod -aG docker yarimadam

runuser -l yarimadam -c 'mkdir .ssh'
runuser -l yarimadam -c 'ssh-keygen -t rsa -N "" -f .ssh/id_rsa'
runuser -l yarimadam -c 'touch .ssh/authorized_keys'

cat .ssh/authorized_keys > /home/yarimadam/.ssh/authorized_keys

sed -i -- 's/#PubkeyAuthentication/PubkeyAuthentication/g' /etc/ssh/sshd_config
sed -i -- 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -i -- 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config

docker network create \
  --driver=bridge \
  --subnet=192.168.1.0/24 \
  --ip-range=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  prod

rm -rf /var/lib/apt/lists/*

# execute the following code manually
# history -c && history -w && poweroff
