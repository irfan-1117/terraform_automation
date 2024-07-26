#Jenkins 

# Create Jenkins on EC2
***************************************************
#!/bin/bash
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
cat /var/lib/jenkins/secrets/initialAdminPassword

#################################################################################