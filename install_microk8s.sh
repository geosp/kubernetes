sudo snap install microk8s --classic
sudo snap alias microk8s.kubectl kubectl
microk8s enable dashboard dns ingress istio metallb metrics-server registry storage
microk8s kubectl expose deployment kubernetes-dashboard --type=LoadBalancer --name=kubernetes-dashboard-external --namespace=kube-system
microk8s kubectl expose deployment registry --type=LoadBalancer --name=registry-external --namespace=container-registry
microk8s kubectl get services --namespace=kube-system
microk8s kubectl get services --namespace=container-registry
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token
