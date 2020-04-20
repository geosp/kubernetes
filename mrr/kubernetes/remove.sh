echo 'Removing mongo rmq and redis to kubernetes...'
#set current name space to mrr
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl delete -f mrr-networkpolicy.yaml
microk8s kubectl delete pvc redis-claim0
microk8s kubectl delete -f redis-deployment.yaml
microk8s kubectl delete service redis
microk8s kubectl delete -f mongo-deployment.yaml
microk8s kubectl delete service mongo
microk8s kubectl delete -f rmqs-deployment.yaml
microk8s kubectl delete service rmqs
microk8s kubectl delete -f mrr-namespace.json
