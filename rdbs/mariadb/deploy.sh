echo 'Deploying rabbitmq...'
kubectl apply -f ../rdbs-namespace.json
kubectl config set-context --current --namespace=rdbs
# If any secret information changes the hashed name 
# identifiying the secret will change too.
kubectl apply -k ./secrets
kubectl apply -f mariadb-data-persistentvolume.yaml
kubectl apply -f mariadb-data-persistentvolumeclaim.yaml
kubectl apply -f mariadb-deployment.yaml
kubectl expose deployment mariadb --type=LoadBalancer --name=mariadb
