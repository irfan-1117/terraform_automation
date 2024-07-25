#!/bin/bash
set -xe
sudo apt-get update -y
sudo apt install docker.io -y
sudo systemctl enable docker
sudo systemctl start docker
#sudo systemctl status docker
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo systemctl enable --now kubelet
sudo apt-get install -y kubernetes-cni nfs-common
sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo swapoff -a
sudo kubeadm init
sudo curl https://raw.githubusercontent.com/projectcalico/calico/v3.28.0/manifests/calico.yaml -O
sudo kubectl apply -f calico.yaml
#kubectl get all -A
