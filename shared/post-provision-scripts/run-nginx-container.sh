#!/bin/bash
# Execute this script as root on the salt master node.

echo "* Install the docker module on the docker host ..."
salt client-docker pip.install docker-py

echo "* Verify the docker module is operational ..."
salt 'docker' docker.version

echo "* Run test container ..."
salt 'docker' docker.run_container hello-world

echo "* Run NGINX container ..."
salt 'docker' state.apply
