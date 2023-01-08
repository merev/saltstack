# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  # Salt Server - CentOS 8.x
  config.vm.define "server" do |server|
    server.vm.box = "merev/centos-stream"
    server.vm.hostname = "server"
    server.vm.network "private_network", ip: "192.168.99.100"
    server.vm.synced_folder "shared/", "/shared"
    server.vm.provision "shell", path: "initial-config/add_hosts.sh"
    server.vm.provision "shell", path: "initial-config/redhat_master_setup.sh"
  
    server.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 2048
      v.cpus = 2
    end
  end
  
  # Salt Client #1 - CentOS 8.x
  config.vm.define "web" do |web|
    web.vm.box = "merev/centos-stream"
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.99.101"
    web.vm.synced_folder "shared/", "/shared"
    web.vm.provision "shell", path: "initial-config/add_hosts.sh"
    web.vm.provision "shell", path: "initial-config/redhat_minion_setup.sh"

    web.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 2
    end
  end

  # Salt Client #2 - Debian 11
  config.vm.define "db" do |db|
    db.vm.box = "merev/debian-11"
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.99.102"
    db.vm.synced_folder "shared/", "/shared"
    db.vm.provision "shell", path: "initial-config/add_hosts.sh"
    db.vm.provision "shell", path: "initial-config/debian_minion_setup.sh"

    db.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 2
    end
  end

    # Salt Client Docker Host - Debian 11
  config.vm.define "docker" do |docker|
    docker.vm.box = "merev/debian-11"
    docker.vm.hostname = "docker"
    docker.vm.network "private_network", ip: "192.168.99.103"
    docker.vm.synced_folder "shared/", "/shared"
    docker.vm.provision "shell", path: "initial-config/add_hosts.sh"
    docker.vm.provision "shell", path: "initial-config/docker_setup.sh"
    docker.vm.provision "shell", path: "initial-config/debian_minion_setup.sh"

    docker.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 1024
      v.cpus = 2
    end
  end
  
end
