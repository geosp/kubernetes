echo 'Removing rabbitmq...'
#set current name space to mrr
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl delete -f ../mrr-networkpolicy.yaml
# microk8s kubectl delete -f rabbitmq-data-persistentvolumeclaim.yaml
# microk8s kubectl delete -f rabbitmq-data-persistentvolume.yaml
microk8s kubectl delete -f rabbitmq-deployment.yaml
microk8s kubectl delete rabbitmq
