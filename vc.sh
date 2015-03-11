#!/bin/bash

date1=$(date +"%s")

#change location to where this script is so it can be fun from anywhere but only act on the cb-se-env directory
location=$(dirname $0);
cd $location

#safeguard in case things go awry
if [[ $location != *"cb-se-env"* ]]
then
  echo "You are in the wrong location, please run this command from the cb-se-snv directory";
  exit
fi

#Vagrant supported commands, vc <command> [command: create, up, destroy, provision, provisionLoop, status, ssh]
if [ "$1" == "create" ]
then
    git pull origin master
    vagrant up configserver
    vagrant up shard1
    vagrant provision shard1
    vagrant up shard2
    vagrant provision shard2
    vagrant up mongos-zend
    vagrant status
elif [ "$1" == "up" ]
then
    vagrant up configserver
    vagrant up shard1
    vagrant up shard2
    vagrant up mongos-zend
    vagrant status
elif [ "$1" == "halt" ]
then
    vagrant halt mongos-zend
    vagrant halt shard2
    vagrant halt shard1
    vagrant halt configserver
    vagrant status
elif [ "$1" == "destroy" ]
then
    vagrant destroy -f mongos-zend
    vagrant destroy -f shard1
    vagrant destroy -f shard2
    vagrant destroy -f configserver
    vagrant status
elif [ "$1" == "provision" ]
then
    vagrant provision configserver
    vagrant provision shard1
    vagrant provision shard2
    vagrant provision mongos-zend
elif [ "$1" == "provisionLoop" ]
then
    vagrant provision configserver
    vagrant provision shard1
    vagrant provision shard2
    false; while [ "$?" -ne "0" ]; do vagrant provision mongos-zend; done
elif [ "$1" == "status" ]
then
    vagrant status
elif [ "$1" == "ssh" ]
then
    vagrant ssh mongos-zend
else
    echo "vc <command> [command: create, up, destroy, provision, provisionLoop, status, ssh]"
fi

date2=$(date +"%s")
diff=$(($date2-$date1))
echo "$(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
