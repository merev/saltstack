#!/bin/bash
# Execute this script as root on the salt master node.

echo "* Copy the website data ..."
mkdir -p /srv/salt/bgapp/
cp -r /shared/bgapp-data/* /srv/salt/bgapp/

echo "* Run BGapp ..."
salt 'db' state.apply
salt 'web' state.apply
