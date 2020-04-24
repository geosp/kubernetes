echo 'Deploying mongodb-ha to kubernetes...'
cp ./config/mongod.conf /storage/data/mrr/mongodb-ha/config
set current name space to mrr
microk8s kubectl apply -f ../mrr-namespace.json
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl apply -f ../mrr-networkpolicy.yaml
microk8s kubectl apply -f mongo-node01-data-persistentvolume.yaml
microk8s kubectl apply -f mongo-node01-data-persistentvolumeclaim.yaml
microk8s kubectl apply -f mongo-node02-data-persistentvolume.yaml
microk8s kubectl apply -f mongo-node02-data-persistentvolumeclaim.yaml
microk8s kubectl apply -f mongo-node03-data-persistentvolume.yaml
microk8s kubectl apply -f mongo-node03-data-persistentvolumeclaim.yaml
microk8s kubectl apply -f mongo-config-persistentvolume.yaml
microk8s kubectl apply -f mongo-config-persistentvolumeclaim.yaml
microk8s kubectl apply -f mongo-node01-deployment.yaml
microk8s kubectl apply -f mongo-node02-deployment.yaml
microk8s kubectl apply -f mongo-node03-deployment.yaml
microk8s kubectl expose deployment mongo-node01 --type=LoadBalancer --name=mongo-node01
microk8s kubectl expose deployment mongo-node02 --type=LoadBalancer --name=mongo-node02
microk8s kubectl expose deployment mongo-node03 --type=LoadBalancer --name=mongo-node03

# Cleanup
# microk8s kubectl delete -f mongo-node01-deployment.yaml
# microk8s kubectl delete -f mongo-node02-deployment.yaml
# microk8s kubectl delete -f mongo-node03-deployment.yaml
# sudo rm -rf /storage/data/mrr/mongodb-ha/node01/data/ /storage/data/mrr/mongodb-ha/node01/log
# sudo rm -rf /storage/data/mrr/mongodb-ha/node02/data/ /storage/data/mrr/mongodb-ha/node02/log
# sudo rm -rf /storage/data/mrr/mongodb-ha/node03/data/ /storage/data/mrr/mongodb-ha/node03/log
# mkdir /storage/data/mrr/mongodb-ha/node01/data/ /storage/data/mrr/mongodb-ha/node01/log
# mkdir /storage/data/mrr/mongodb-ha/node02/data/ /storage/data/mrr/mongodb-ha/node02/log

# Initializing the cluster after deployment.
# mkdir /storage/data/mrr/mongodb-ha/node03/data/ /storage/data/mrr/mongodb-ha/node03/log
# The first time the cluster runs it needs to be initialized. This information is persisted from the point on.
# On mongo-node01 run this command the ip addreses willbe the cluster ip addresses for each service.
# rs.initiate(
#    {
#       _id: "rs0",
#       version: 1,
#       members: [
#          { _id: 0, host : "mongo-node01.mrr.svc.mxcluster.local:27017" },
#          { _id: 1, host : "mongo-node02.mrr.svc.mxcluster.local:27017" },
#          { _id: 2, host : "mongo-node03.mrr.svc.mxcluster.local:27017", arbiterOnly: true }
#       ]
#    }
# )
# To check the cluster status run this: rs.status()
# On mongo-node02
# db.getMongo().setSlaveOk()
