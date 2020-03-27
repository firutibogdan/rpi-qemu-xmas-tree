#!/bin/bash

# check for sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run with sudo"
  exit
fi

# get ip
ip=$(ip a s dev eth0 | grep "inet " | sed -e 's/  */ /g' | cut -d ' ' -f3 | cut -d '/' -f 1)

# get mask
mask=$(ip a s dev eth0 | grep "inet " | sed -e 's/  */ /g' | cut -d ' ' -f3 | cut -d '/' -f 2)

# get gateway
route=$(route | grep default | sed 's/  */ /g' | cut -d ' ' -f 2)

sudo brctl addbr virbr0
sudo brctl addif virbr0 eth0
sudo ifconfig eth0 0.0.0.0
sudo ifconfig virbr0 $ip/$mask
sudo route add default gw $route

# add directory and allow virbr0
sudo mkdir /etc/qemu
sudo  sh -c "echo 'allow virbr0' > /etc/qemu/bridge.conf"

