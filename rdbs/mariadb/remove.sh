echo 'Deploying rabbitmq...'
kubectl config set-context --current --namespace=rdbs
kubectl delete -f mariadb-deployment.yaml
