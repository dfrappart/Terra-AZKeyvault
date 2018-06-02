#!/bin/bash


sudo yum install -y epel-release
sudo yum install -y nginx
sudo systemctl start nginx


echo "bootscript done" > /tmp/results.txt

exit 0