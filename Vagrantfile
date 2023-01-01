# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.ssh.insert_key = false

  # Salt Server - CentOS 8.x
  config.vm.define "server" do |server|
    server.vm.box = "merev/centos-stream-8"
    server.vm.hostname = "server"
    server.vm.network "private_network", ip: "192.168.99.100"
    server.vm.provision "shell", path: "initial-config/add_hosts.sh"
    server.vm.provision "shell", path: "initial-config/redhat_master_setup.sh"

    server.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 2048
      v.cpus = 1
    end
  end
  
  # Salt Client #1 - CentOS 8.x
  config.vm.define "web1" do |web1|
    web1.vm.box = "merev/centos-stream-8"
    web1.vm.hostname = "client-web-1"
    web1.vm.network "private_network", ip: "192.168.99.101"
    web1.vm.provision "shell", path: "initial-config/add_hosts.sh"
    web1.vm.provision "shell", path: "initial-config/redhat_minion_setup.sh"

    web1.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 512
      v.cpus = 1
    end
  end

  # Salt Client #2 - Debian 11
  config.vm.define "web2" do |web2|
    web2.vm.box = "merev/debian-11"
    web2.vm.hostname = "client-web-2"
    web2.vm.network "private_network", ip: "192.168.99.102"
    web2.vm.provision "shell", path: "initial-config/add_hosts.sh"
    web2.vm.provision "shell", path: "initial-config/debian_minion_setup.sh"

    web2.vm.provider "virtualbox" do |v|
      v.gui = false
      v.memory = 512
      v.cpus = 1
    end
  end
  
end
