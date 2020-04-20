microk8s kubectl scale deployment mongo --replicas=$1 --namespace=mrr
microk8s kubectl scale deployment redis --replicas=$1 --namespace=mrr
microk8s kubectl scale deployment rmqs --replicas=$1 --namespace=mrr
microk8s kubectl get deployments --namespace=mrr
