#!/bin/bash

sudo yum update -y
sudo yum search docker
sudo yum info docker
sudo yum install docker -y
sudo systemctl enable docker.service
sudo systemctl start docker.service
sudo systemctl status docker.service
curl -sL https://raw.githubusercontent.com/sakit333/ansible_insta/refs/heads/main/worker_ansible_node.sh | bash
sudo usermod -aG docker ansible