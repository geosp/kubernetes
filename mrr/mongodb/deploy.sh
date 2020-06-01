echo 'Deploying mongodb...'
microk8s kubectl apply -f ../mrr-namespace.json
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl apply -f ../mrr-networkpolicy.yaml
microk8s kubectl apply -f mongo-data-persistentvolume.yaml
microk8s kubectl apply -f mongo-data-persistentvolumeclaim.yaml
microk8s kubectl apply -f mongo-deployment.yaml
microk8s kubectl expose deployment mongo --type=LoadBalancer --name=mongo
