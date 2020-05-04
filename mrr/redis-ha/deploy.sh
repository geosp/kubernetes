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
kubectl apply -f ../mrr-namespace.json
kubectl config set-context --current --namespace=mrr
kubectl apply -f ../mrr-networkpolicy.yaml
kubectl apply -f redis-ha-config-persistentvolume.yaml
kubectl apply -f redis-ha-config-persistentvolumeclaim.yaml
kubectl apply -f redis-ha-data-persistentvolume.yaml
kubectl apply -f redis-ha-data-persistentvolumeclaim.yaml
kubectl apply -f create-master-deployment.yaml
kubectl expose deployment redis-ha-cluster-master --type=LoadBalancer --name=redis-ha-cluster-master
kubectl apply -f create-sentinel-deployment.yaml
kubectl expose deployment redis-ha-cluster-sentinel --type=LoadBalancer --name=redis-ha-cluster-sentinel
kubectl apply -f create-slave-deployment.yaml
kubectl expose deployment redis-ha-cluster-slave --type=LoadBalancer --name=redis-ha-cluster-slave
