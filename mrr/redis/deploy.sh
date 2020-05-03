echo 'Deploying rabbitmq...'
microk8s kubectl apply -f ../mrr-namespace.json
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl apply -f ../mrr-networkpolicy.yaml
microk8s kubectl apply -f redis-data-persistentvolume.yaml
microk8s kubectl apply -f redis-data-persistentvolumeclaim.yaml
microk8s kubectl apply -f redis-deployment.yaml
microk8s kubectl expose deployment redis --type=LoadBalancer --name=redis
