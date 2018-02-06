# Prerequisites

* [Download and install Vagrant.](https://www.vagrantup.com/) [More info about Vagrant here.](https://www.vagrantup.com/docs/)
* [Virtualbox 5.0.X. (recommended)](https://www.virtualbox.org/wiki/Download_Old_Builds_5_0) (5.1 should work but if you're having issue, consider downgrading to 5.0)

# Installation

* `git clone git@github.com:herpaderpaldent/eveseat-vagrant.git`
* `cd eveseat-vagrant`
* `vagrant up`. It can take some times since it's deploying a whole dev environnement (mysql, php, apache, composer...) and configuring SeAT.
* `vagrant ssh` to open an SSH connection to the machine.

# Usage

You can now connect to your SeAT instance by browsing to `http://{ip address of the VM}/` (grap it with `ifconfig`).

# Credentials

* SeAT `admin:password`
* MySQL `root:password` (remote access allowed)

# Troubleshooting

If the installation fails, execute `vagrant destroy` to rollback to a clean state.
