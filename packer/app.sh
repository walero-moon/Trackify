#!/bin/bash

sleep 30
sudo yum update -y
sudo yum install -y gcc-c++ make git
curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -
sudo yum install -y nodejs

cd ~/ && git clone https://github.com/walero-moon/Trackify.git
cd Trackify && npm install

sudo mv /tmp/trackify.service /etc/systemd/system/trackify.service
sudo systemctl start trackify.service
sudo systemctl enable trackify.service