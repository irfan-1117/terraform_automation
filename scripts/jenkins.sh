#!/bin/bash
# install python pip package
apt-get update -y
apt install python3-pip -y

# install awscli
apt-get update -y
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

# Install docker
apt-get update -y
apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable" -y
apt-get update
apt-get install -y docker-ce
usermod -aG docker ubuntu

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/1.21.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

#docker container run -d -p 80:80 --name webserver httpd:latest
#docker container run -d -p 8080:8080 --name appserver tomcat:latest