#!/bin/bash

#update stuff
sudo apt-get update
sudo apt upgrade -y
sudo apt install apt-transport-https -y
sudo apt-get clean

# add nico user
sudo adduser test --gecos "Nico Kruger,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "test:test@123" | sudo chpasswd
# add nico pub key
mkdir -p /home/nico/.ssh
echo "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEED62Zh6X7y60Wjbs0ZUaC0ydIh2Q7VUI1SBzQhz1YcgB2NTxkYkhhfVdgG6bcBE4sft7PlGim2hvYtlRj95zY= linic@cyberx" >> /home/nico/.ssh/authorized_keys
chmod -R go= /home/nico/.ssh
chown -R nico:nico /home/nico/.ssh


# install mdns
hostnamectl set-hostname ubuntu
sudo apt install avahi-daemon -y
systemctl start avahi-daemon
systemctl enable avahi-daemon