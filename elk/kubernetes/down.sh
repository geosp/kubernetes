microk8s kubectl scale deployment elasticsearch --replicas=0 --namespace=elk
microk8s kubectl scale deployment kibana --replicas=0 --namespace=elk
microk8s kubectl scale deployment logstash --replicas=0 --namespace=elk
