echo 'Removing redis...'
#set current name space to mrr
#microk8s kubectl config set-context --current --namespace=mrr
#microk8s kubectl delete -f ../mrr-networkpolicy.yaml
#microk8s kubectl delete -f redis-data-persistentvolume.yaml
#microk8s kubectl delete -f redis-data-persistentvolumeclaim.yaml
microk8s kubectl delete -f redis-deployment.yaml
microk8s kubectl delete service redis
