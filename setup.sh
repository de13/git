#!/bin/bash

# TODO
# - make wetty work with SSL certificates
# - Run wetty on port 443

sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common git screen

# Git server
sudo useradd -ms /bin/bash git 
sudo su - git -c "mkdir -m 700 ~/.ssh"
sudo su - git -c "touch ~/.ssh/authorized_keys && chmod 0600 ~/.ssh/authorized_keys"
sudo useradd -ms /bin/bash workshop
echo "workshop:bandersnatch" | sudo chpasswd
sudo su - workshop -c "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa"
sudo su -c "cat /home/workshop/.ssh/id_rsa.pub >> /home/git/.ssh/authorized_keys"
sudo su -c "mkdir -p /srv/git && chown git. /srv/git"
sudo su - git -c "mkdir /srv/git/demo.git && git init --bare /srv/git/demo.git"

# Wetty
curl -fsSL https://deb.nodesource.com/setup_14.x | sudo bash -
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /usr/share/keyrings/yarnkey.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/yarnkey.gpg] https://dl.yarnpkg.com/debian stable main" |sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo DEBIAN_FRONTEND=noninteractive apt-get install yarn gcc g++ make python sudo -y
sudo yarn global add wetty
sudo screen -d -m sudo wetty --base / -p 80 &
