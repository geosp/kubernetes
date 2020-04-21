#!/bin/bash
#set current name space to development
microk8s kubectl config set-context --current --namespace=elk
#delete resources
microk8s kubectl delete -f logstash-deployment.yaml
microk8s kubectl delete service logstash
microk8s kubectl delete -f kibana-deployment.yaml
microk8s kubectl delete service kibana
microk8s kubectl delete -f elasticsearch-deployment.yaml
microk8s kubectl delete service elasticsearch
microk8s kubectl delete -f elk-namespace.json
