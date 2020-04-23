echo 'Build redis-ha image...'
image='redis-ha'
cp ./config/*.conf /storage/data/mrr/redis-ha/config
docker build . -t $image
if [ -z "$1" ]
then
    registry="192.168.1.165:5000"
else
    registry=$1
fi
docker tag $image "${registry}/${image}"
docker push "${registry}/${image}"
echo 'Deploying redis-ha to kubernetes...'
#set current name space to mrr
microk8s kubectl apply -f ../mrr-namespace.json
microk8s kubectl config set-context --current --namespace=mrr
microk8s kubectl apply -f ../mrr-networkpolicy.yaml
microk8s kubectl apply -f redis-config-persistentvolume.yaml
microk8s kubectl apply -f redis-config-persistentvolumeclaim.yaml
microk8s kubectl apply -f redis-data-persistentvolume.yaml
microk8s kubectl apply -f redis-data-persistentvolumeclaim.yaml
microk8s kubectl apply -f create-master-deployment.yaml
microk8s kubectl expose deployment redis-ha-cluster-master --type=LoadBalancer --name=redis-ha-cluster-master
microk8s kubectl apply -f create-sentinel-deployment.yaml
microk8s kubectl expose deployment redis-ha-cluster-sentinel --type=LoadBalancer --name=redis-ha-cluster-sentinel
microk8s kubectl apply -f create-slave-deployment.yaml
