echo 'Deploying rabbitmq...'
microk8s kubectl apply -f ../mrr-namespace.json
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl apply -f ../mrr-networkpolicy.yaml
microk8s kubectl apply -f rabbitmq-data-persistentvolume.yaml
microk8s kubectl apply -f rabbitmq-data-persistentvolumeclaim.yaml
microk8s kubectl apply -f rabbitmq-deployment.yaml
microk8s kubectl expose deployment rabbitmq --type=LoadBalancer --name=rabbitmq
