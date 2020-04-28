
microk8s kubectl config set-context --current --namespace=mrr
# Cleanup
microk8s kubectl delete -f mongo-node01-deployment.yaml
microk8s kubectl delete -f mongo-node02-deployment.yaml
microk8s kubectl delete -f mongo-node03-deployment.yaml
microk8s kubectl delete service mongo-node01
microk8s kubectl delete service mongo-node02
microk8s kubectl delete service mongo-node03

# sudo rm -rf /storage/data/mrr/mongodb-ha/node01/data/ /storage/data/mrr/mongodb-ha/node01/log
# sudo rm -rf /storage/data/mrr/mongodb-ha/node02/data/ /storage/data/mrr/mongodb-ha/node02/log
# sudo rm -rf /storage/data/mrr/mongodb-ha/node03/data/ /storage/data/mrr/mongodb-ha/node03/log
# mkdir /storage/data/mrr/mongodb-ha/node01/data/ /storage/data/mrr/mongodb-ha/node01/log
# mkdir /storage/data/mrr/mongodb-ha/node02/data/ /storage/data/mrr/mongodb-ha/node02/log