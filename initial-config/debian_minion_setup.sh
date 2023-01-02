#!/bin/bash

echo "* Add any prerequisites ..."
apt-get update -y && apt-get install -y python3 python3-pip

echo "* Download the bootstrap script ..."
wget -O bootstrap-salt.sh https://bootstrap.saltstack.com

echo "* Install the latest stable version of just the minion part and run it as a daemon ..."
sh bootstrap-salt.sh

echo "* Point the minions to the master ..."
sed -i "16s/salt/server/" /etc/salt/minion
sed -i "16s/#//" /etc/salt/minion

echo "* Restart the service and show its status..."

systemctl restart salt-minion
systemctl status salt-minion

