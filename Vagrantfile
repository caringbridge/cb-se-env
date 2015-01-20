Vagrant.configure('2') do |config|

  # Prepare berks
  [:up, :provision, :destroy].each do |cmd|
    config.trigger.before cmd, stdout: true, force: true, vm: /^configserver$/ do
      run 'rm -f Berksfile.lock'
      run 'mkdir chef-repo'
      run 'berks package chef-repo/cookbooks.tar.gz'
      run 'tar -C chef-repo -xzf chef-repo/cookbooks.tar.gz'
      run 'pkill -f chef-zero'
    end
  end

  # Install Chef
  config.omnibus.chef_version = :latest
  config.omnibus.install_url = 'http://www.opscode.com/chef/install.sh'

  # Chef-Zero
  config.chef_zero.enabled = true
  config.chef_zero.cookbooks = 'chef-repo/cookbooks'

  # Disabling the Berkshelf plugin
  config.berkshelf.enabled = false

  config.vm.define 'configserver' do |cs|
    # Set hostname
    cs.vm.hostname = 'configserver'

    # Every Vagrant virtual environment requires a box to build off of
    cs.vm.box = 'chef/centos-6.5'

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system
    cs.vm.box_url = 'http://sun4600.cbeagan.org/centos-chef.box'

    cs.vm.network :private_network, ip: '33.33.33.40'

    # Customize VM CPU and Memory
    config.vm.provider "virtualbox" do |v|
      # v.memory = 1024
      v.memory = 512
      v.cpus = 1
    end

    # Chef run to create things
    cs.vm.provision :chef_client do |chef|
      chef.json = {
        'mongodb' => {
          'configserver_url' => '33.33.33.40'
        }
      }

      chef.add_recipe 'role-mongodb-configserver::default'
    end
  end

  config.vm.define 'shard1' do |shard1|
    # Set hostname
    shard1.vm.hostname = 'shard1'

    # Every Vagrant virtual environment requires a box to build off of
    shard1.vm.box = 'chef/centos-6.5'

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system
    shard1.vm.box_url = 'http://sun4600.cbeagan.org/centos-chef.box'

    shard1.vm.network :private_network, ip: '33.33.33.42'

    # Customize VM CPU and Memory
    config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end

    # Chef run to create things
    shard1.vm.provision :chef_client do |chef|
      chef.add_recipe 'role-mongodb-shard1::default'
      chef.add_recipe 'role-mongodb-replicaset1::default'
    end
  end

  config.vm.define 'shard2' do |shard2|
    # Set hostname
    shard2.vm.hostname = 'shard2'

    # Every Vagrant virtual environment requires a box to build off of
    shard2.vm.box = 'chef/centos-6.5'

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system
    shard2.vm.box_url = 'http://sun4600.cbeagan.org/centos-chef.box'

    shard2.vm.network :private_network, ip: '33.33.33.43'

    # Customize VM CPU and Memory
    config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end

    # Chef run to create things
    shard2.vm.provision :chef_client do |chef|
      chef.add_recipe 'role-mongodb-shard2::default'
      chef.add_recipe 'role-mongodb-replicaset2::default'
    end
  end

  config.vm.define 'mongos-zend' do |mongos|
    # Set hostname
    mongos.vm.hostname = 'mongos-zend'

    # Every Vagrant virtual environment requires a box to build off of
    mongos.vm.box = 'chef/centos-6.5'

    # The url from where the 'config.vm.box' box will be fetched if it
    # doesn't already exist on the user's system
    mongos.vm.box_url = 'http://sun4600.cbeagan.org/centos-chef.box'

    mongos.vm.network :private_network, ip: '33.33.33.41'

    # Customize VM CPU and Memory
    config.vm.provider "virtualbox" do |v|
      v.memory = 2048
      v.cpus = 2
    end

    ### Set up a deploy of the platform code base ###
    puts 'Set up a deploy of the platform code base'
    local_project_path = '../platform'
    vagrant_project_path = '/var/www/platform'

    # Directories to share between local and vagrant machines
    # We are serving the app out of /opt/platform because it should be
    # served by (owned by apache), and the default shared directory /vagrant
    # is owned by vagrant. /var/www gets built by zend-server and happens too
    # late in the build flow
    # NOTE: synced_folder is built in on vagrant (https://docs.vagrantup.com/v2/synced-folders/basic_usage.html)
    # @todo: Consider moving to /vagrant (and letting vagrant run apache and zend-server)
    # or find a way to move the app to /var/www
    # @todo: We could work with the Sys Admins to more closely match production permissions,
    # but this should be close enough for government work
    mongos.vm.synced_folder local_project_path, vagrant_project_path,
      :owner => 'apache',
      :group => 'apache',
      :mount_options => ["dmode=775,fmode=775"]

      # Chef run to create things
       mongos.vm.provision :shell, :inline => <<-EOF
       echo export APPLICATION_ENV=vagrant-cluster > /etc/profile.d/vagrant.sh
       EOF

      mongos.vm.provision :chef_client do |chef|
        chef.add_recipe 'role-mongodb-mongos::default'
        chef.add_recipe 'role-zendserver::default'
        chef.add_recipe 'role-rabbitmq::default'
        chef.add_recipe 'role-twemcache::default'
        chef.add_recipe 'role-sphinx::default'
        chef.add_recipe 'cb-platform::default'
      end
    end
  end
