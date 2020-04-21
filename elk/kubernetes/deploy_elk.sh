#!/bin/bash
getVolumePath() {
    echo $(microk8s kubectl describe pv $(microk8s kubectl get pv | grep $1 | head -n1 | awk '{print $1;}') | grep Path: | head -n2 | awk '{print $2;}')
}
#set current name space to development
microk8s kubectl apply -f elk-namespace.json
microk8s kubectl config set-context --current --namespace=elk
#create resources
microk8s kubectl apply -f ./system/shared-storageclass.yaml
microk8s kubectl apply -f logstash-persistentvolume.yaml
microk8s kubectl apply -f logstash-persistentvolumeclaim.yaml
microk8s kubectl apply -f logstash-deployment.yaml
microk8s kubectl expose deployment logstash --type=LoadBalancer --name=logstash
#microk8s kubectl apply -f logstash-claim0-persistentvolumeclaim.yaml
#microk8s kubectl apply -f logstash-claim1-persistentvolumeclaim.yaml
microk8s kubectl apply -f kibana-deployment.yaml
microk8s kubectl expose deployment kibana --type=LoadBalancer --name=kibana
microk8s kubectl apply -f elasticsearch-deployment.yaml
microk8s kubectl expose deployment elasticsearch --type=LoadBalancer --name=elasticsearch
logstashSettingsPath=$(getVolumePath 'logstash-pv-claim')
logstashConfigurationPath=$(getVolumePath 'logstash-pv-claim')
echo "Copying configuration to path: ${logstashConfigurationPath}"
cp -r ../logstash/custom.conf $logstashConfigurationPath
echo "Copying settings to path: ${logstashSettingsPath}"
cp -r ../logstash/logstash.yml $logstashSettingsPath