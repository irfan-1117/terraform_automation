#!/bin/bash
# install python pip package
apt-get update -y
apt install python3-pip -y

# install awscli
sudo apt install unzip -y 
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install jenkins
sudo apt update -y
sudo apt upgrade -y
sudo apt install openjdk-11-jdk -y
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5BA31D57EF5975CA
sudo apt update -y
sudo apt install jenkins -y
sudo systemctl start Jenkins
sudo systemctl enable Jenkins
sudo systemctl status Jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword



