#!/bin/bash
# Elasticsearch settings required on the node running the ES pod.
# execute: sudo sysctl -w vm.max_map_count=262144
# add vm.max_map_count=262144 to the end of the file /etc/sysctl.conf making this change permanent.
getVolumePath() {
    echo $(microk8s kubectl describe pv $(microk8s kubectl get pv | grep $1 | head -n1 | awk '{print $1;}') | grep Path: | head -n2 | awk '{print $2;}')
}
#set current name space to development
microk8s kubectl apply -f elk-namespace.json
microk8s kubectl config set-context --current --namespace=elk
#create resources
microk8s kubectl apply -f ../shared-storageclass.yaml
microk8s kubectl apply -f logstash-persistentvolume.yaml
microk8s kubectl apply -f logstash-persistentvolumeclaim.yaml
microk8s kubectl apply -f elasticsearch-data-persistentvolume.yaml
microk8s kubectl apply -f elasticsearch-data-persistentvolumeclaim.yaml
microk8s kubectl apply -f elasticsearch-hunspell-persistentvolume.yaml
microk8s kubectl apply -f elasticsearch-hunspell-persistentvolumeclaim.yaml
microk8s kubectl create configmap elasticsearch-config --from-file=elasticsearch/elasticsearch.yml
microk8s kubectl apply -f elasticsearch-deployment.yaml
microk8s kubectl apply -f logstash-deployment.yaml
microk8s kubectl apply -f kibana-deployment.yaml
microk8s kubectl expose deployment logstash --type=LoadBalancer --name=logstash
microk8s kubectl expose deployment kibana --type=LoadBalancer --name=kibana
microk8s kubectl expose deployment elasticsearch --type=LoadBalancer --name=elasticsearch
logstashSettingsPath=$(getVolumePath 'logstash-pv-claim')
echo "Copying configuration to path: ${logstashSettingsPath}"
cp -r ./logstash/custom.conf $logstashSettingsPath
echo "Copying settings to path: ${logstashSettingsPath}"
cp -r ./logstash/logstash.yml $logstashSettingsPath