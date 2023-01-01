#!/bin/bash

echo "* Add any prerequisites ..."
apt-get update -y && apt-get install -y python3

echo "* Add the key ..."
curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/debian/11/amd64/latest/salt-archive-keyring.gpg

echo "* Create the apt sources list file and update package information ..."
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/debian/11/amd64/latest bullseye main" | tee /etc/apt/sources.list.d/salt.list
apt-get update -y

echo "* Download the bootstrap script ..."
wget -O bootstrap-salt.sh https://bootstrap.saltstack.com

echo "* Install the latest stable version – just the master (-M), without the minion (-N) part, do not start the daemons (-X) ..."
sh bootstrap-salt.sh -M -N -X

echo "* Enable, start the Salt master service, and check if everything is okay ..."
systemctl enable --now salt-master
systemctl status salt-master
















