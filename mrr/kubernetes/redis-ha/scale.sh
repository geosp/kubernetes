kubectl config set-context --current --namespace=mrr
microk8s kubectl scale deployment redis-ha-cluster-master --replicas=$1
microk8s kubectl scale deployment redis-ha-cluster-sentinel --replicas=$1
microk8s kubectl scale deployment redis-ha-cluster-slave --replicas=$1
microk8s kubectl get deployments

