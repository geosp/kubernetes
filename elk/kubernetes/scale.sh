kubectl config set-context --current --namespace=elk
microk8s kubectl scale replicaset elasticsearch --replicas=$1
microk8s kubectl scale deployment kibana --replicas=$1
microk8s kubectl scale deployment logstash --replicas=$1
microk8s kubectl get deployments
microk8s kubectl get  replicasets

