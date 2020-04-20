echo 'Deploying mongo rmq and redis to kubernetes...'
#set current name space to mrr
microk8s kubectl apply -f mrr-namespace.json
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl apply -f mrr-networkpolicy.yaml
microk8s kubectl apply -f redis-claim0-persistentvolumeclaim.yaml
microk8s kubectl apply -f redis-deployment.yaml
microk8s kubectl expose deployment redis --type=LoadBalancer --name=redis
microk8s kubectl apply -f mongo-deployment.yaml
microk8s kubectl expose deployment mongo --type=LoadBalancer --name=mongo
microk8s kubectl apply -f rmqs-deployment.yaml
microk8s kubectl expose deployment rmqs --type=LoadBalancer --name=rmqs
