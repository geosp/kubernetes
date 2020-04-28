echo 'Removing redis-ha from kubernetes...'
# delete
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl delete -f create-master-deployment.yaml
microk8s kubectl delete -f create-sentinel-deployment.yaml
microk8s kubectl delete -f create-slave-deployment.yaml
microk8s kubectl delete service redis-ha-cluster-master
microk8s kubectl delete service redis-ha-cluster-sentinel
# rm /storage/data/mrr/redis-ha/config/*.conf
# sudo rm -rf /storage/data/mrr/redis-ha/data
# mkdir /storage/data/mrr/redis-ha/data