#!/bin/bash

#yum -y update
sudo yum -y install httpd
sudo apachectl start

echo "customscript done" > /tmp/results.txt

exit 0