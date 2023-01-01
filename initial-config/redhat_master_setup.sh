#!/bin/bash

echo "* Add any prerequisites ..."
dnf install -y python3

echo "* Add the key ..."
rpm --import https://repo.saltproject.io/py3/redhat/8/x86_64/latest/SALTSTACK-GPG-KEY.pub

echo "* Add the repository ..."
curl -fsSL https://repo.saltproject.io/py3/redhat/8/x86_64/latest.repo | tee /etc/yum.repos.d/salt.repo

echo "* Download the bootstrap script ..."
wget -O bootstrap-salt.sh https://bootstrap.saltstack.com

echo "* Install the latest stable version – just the master (-M), without the minion (-N) part, do not start the daemons (-X) ..."
sh bootstrap-salt.sh -M -N -X

echo "* Open the firewall ports ..."
firewall-cmd --permanent --add-port=4505-4506/tcp
firewall-cmd --reload

echo "* Enable, start the Salt master service, and check if everything is okay ..."
systemctl enable --now salt-master
systemctl status salt-master



















