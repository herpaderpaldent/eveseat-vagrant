# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :shell, path: "provisions/bootstrap.sh"
  config.vm.network "private_network", type: "dhcp"
  config.vm.synced_folder "F:/WebFiles/seat-dev", "/var/www/seat"
  
  
	config.vm.provider "virtualbox" do |v|
		v.memory = 2048
		v.cpus = 2
	end
end
