#!/bin/bash

echo "bootscript initiated" > /tmp/results.txt 
sudo apt-get update -y
sudo apt-get install -y nginx
sudo systemctl start nginx


echo "bootscript done" >> /tmp/results.txt

exit 0