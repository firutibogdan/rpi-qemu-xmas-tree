#!/bin/bash

# check for sudo
if [ "$EUID" -ne 0 ]
  then echo "Please run with sudo"
  exit
fi

# qemu starter command
sudo qemu-system-arm -machine versatilepb -cpu arm1176 -kernel zImage -append " root=/dev/sda2 TERM=xterm-256color console=tty0 console=ttyAMA0" -drive file=rpi-basic-image.img,index=0,media=disk,format=raw -net nic,model=smc91c111,netdev=bridge -netdev bridge,br=virbr0,id=bridge -serial stdio -display curses
