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
A total of 2 VMs will be spun up.  Total resources for all 2 VMs:
* 2 x CPUs
* 1 GB Memory
* 3.4 GB HDD
* 4 min 40 sec (Time it roughly takes to spin up everything)

How to Use
==========
* `vagrant up` - Bring up the environment
* `vagrant destroy` - Destroy the environment
* `vagrant ssh [instance_name]` - Login to an instance
* `vagrant ssh mongos` - Login to mongos instance
* `vagrant status` - Check status of your environment

Notes
=====
There is an issue with i18n gem installed with vagrant plugins.  See https://github.com/andrewgross/vagrant-chef-zero/issues/51.  Please be sure to follow instructions @ https://github.com/andrewgross/vagrant-chef-zero/issues/51#issuecomment-57443582 to workaround this issue until PR https://github.com/svenfuchs/i18n/pull/292 is accepted and merged and a new release of i18n provided and gem dependencies updated.
