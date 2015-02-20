#!/bin/bash

vagrant up configserver && vagrant up shard1 && vagrant provision shard1 && vagrant up shard2 && vagrant provision shard2 && vagrant up mongos-zend
