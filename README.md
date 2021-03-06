Mongo Environment
=================
This is a collection of code for spinning up a mongo environment consisting of:
* mongos & zend
* config server
* 2 x replicast shards (2 x servers) (TBD)

Requirements
============
* vagrant-omnibus - Install chef-client to VMs
* vagrant-chef-zero - Run a in memory chef-server on your host system
* vagrant-triggers - Run scripts before/after VM commands
* vagrant-berkshelf -
* chef-dk

```
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-chef-zero
vagrant plugin install vagrant-triggers
vagrant plugin install vagrant-berkshelf
```

Resources Needed
================
A total of 4 VMs will be spun up.  Total resources for all 4 VMs:
* 4 x CPUs
* 3 GB Memory
* 3.4 GB HDD
* 30 min (Time it roughly takes to spin up everything)

How to Use
==========
* `vagrant up` - Bring up the environment
* `vagrant destroy` - Destroy the environment
* `vagrant ssh [instance_name]` - Login to an instance
* `vagrant ssh mongos-zend` - Login to mongos instance
* `vagrant status` - Check status of your environment

Alias
=====
There is a shortcut alias for setting up, halting, provisioning, etc your vagrant cluster if you call the vc.sh file.  This file can be called from
any directory which is nice if you are in say platform and you want to halt your vm. Set the following in your .bashrc or .profile, whichever you use:

`alias vc="/path/to/your/cb-se-env/vc.sh"`

This can then be run as from any directory

```
vc up
vc status
vc ssh
```

There is also this way of managing your cluster with just an alias as described here: https://github.com/lostphilosopher/dot_files/blob/master/caringbridge_mac_bash#L68-115

Notes
=====
There is an issue with i18n gem installed with vagrant plugins.  See https://github.com/andrewgross/vagrant-chef-zero/issues/51.  Please be sure to follow instructions @ https://github.com/andrewgross/vagrant-chef-zero/issues/51#issuecomment-57443582 to workaround this issue until PR https://github.com/svenfuchs/i18n/pull/292 is accepted and merged and a new release of i18n provided and gem dependencies updated.
