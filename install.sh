#!/bin/bash

# Following tutorial https://kubecloud.io/setting-up-a-kubernetes-1-11-raspberry-pi-cluster-using-kubeadm-952bbda329c8

# Docker
sudo apt install vim docker.io -y && sudo systemctl enable docker

# Kubernetes
sudo apt install --reinstall software-properties-common
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update && sudo apt install kubeadm -y

# Link to another machine
ssh-keygen -t rsa -N "" -f ~/.ssh/to-minion.key
ssh-copy-id -i ~/.ssh/to-minion.key pi@raspberrypi-minion

# Docker on another machine
ssh -i ~/.ssh/to-minion.key pi@raspberrypi-minion 'sudo apt install vim docker.io -y && sudo systemctl enable docker'
ssh -i ~/.ssh/to-minion.key pi@raspberrypi-minion 'curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add'
ssh -i ~/.ssh/to-minion.key pi@raspberrypi-minion 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list'
ssh -i ~/.ssh/to-minion.key pi@raspberrypi-minion 'sudo apt-get update && sudo apt install kubeadm -y'

sudo swapoff -a

