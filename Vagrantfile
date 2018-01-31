# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.provision :shell, path: "provisions/bootstrap.sh"
  config.vm.network "private_network", type: "dhcp"

  # if you want to use synced folder on windows uncomment below line and
  # change it to the path you'd like to use.
  #config.vm.synced_folder "F:/WebFiles/seat-dev", "/var/www/seat"


	config.vm.provider "virtualbox" do |v|
		v.memory = 2048
		v.cpus = 2
	end

  config.vm.network "forwarded_port", guest: 8000, host: 8000

end
