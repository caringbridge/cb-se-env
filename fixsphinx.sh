#!/bin/bash

# This will vagrant-ssh into your mongos-zend VM and (re)start the Sphinx searchd service. That usually clears up most Sphinx-related mischief.

pushd . > /dev/null # remember where we were (silently)

cd ~/cb-se-env

echo "Fixing Sphinx..."

vagrant ssh mongos-zend -- -t 'sudo service searchd stop && /var/www/platform/scripts/cb search rotate && sudo service searchd start;'

popd > /dev/null # go back to where we were (silently)

echo "Search should now work on your local environment!"
