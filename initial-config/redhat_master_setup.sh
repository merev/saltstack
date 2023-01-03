#!/bin/bash

echo "* Stop SE Linux ..."
sudo setenforce permissive
sudo sed -i 's\=enforcing\=permissive\g' /etc/sysconfig/selinux

echo "* Add any prerequisites ..."
dnf install -y python3 python3-pip

echo "* Add the key ..."
rpm --import https://repo.saltproject.io/py3/redhat/8/x86_64/latest/SALTSTACK-GPG-KEY.pub

echo "* Add the repository ..."
curl -fsSL https://repo.saltproject.io/py3/redhat/8/x86_64/latest.repo | tee /etc/yum.repos.d/salt.repo

echo "* Download the bootstrap script ..."
wget -O bootstrap-salt.sh https://bootstrap.saltstack.com

echo "* Install the latest stable version – just the master (-M), without the minion (-N) part, do not start the daemons (-X) ..."
sh bootstrap-salt.sh -M -N -X

echo "* Prepare the /srv/salt and /srv/pillar folders ..."
sed -i '685,687s/#//' /etc/salt/master
mkdir -p /srv/salt
sed -i '850,852s/#//' /etc/salt/master
mkdir -p /srv/pillar

echo "* Copy the configuration data ..."
cp /shared/master/* /srv/salt/

echo "* Open the firewall ports ..."
firewall-cmd --permanent --add-port=4505/tcp
firewall-cmd --permanent --add-port=4506/tcp
firewall-cmd --reload

echo "* Enable, start the Salt master service, and check if everything is okay ..."
systemctl enable --now salt-master
systemctl status salt-master

echo "* Make the master to accept new keys periodically ..."
touch /etc/cron.d/salt-keys
echo "* * * * * root salt-key -Ay" | tee /etc/cron.d/salt-keys



















