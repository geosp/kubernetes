echo 'Removing mongo...'
#set current name space to mrr
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl delete -f ../mrr-networkpolicy.yaml
microk8s kubectl delete -f mongo-data-persistentvolume.yaml
microk8s kubectl delete -f mongo-data-persistentvolumeclaim.yaml
microk8s kubectl delete -f mongo-deployment.yaml
microk8s kubectl delete mongo
