echo 'Deploying mssql...'
kubectl apply -f ../rdbs-namespace.json
kubectl config set-context --current --namespace=rdbs
# If any secret information changes the hashed name 
# identifiying the secret will change too.
kubectl apply -k ./secrets
kubectl apply -f mssql-data-persistentvolume.yaml
kubectl apply -f mssql-data-persistentvolumeclaim.yaml
kubectl apply -f mssql-deployment.yaml
kubectl expose deployment mssql --type=LoadBalancer --name=mssql
