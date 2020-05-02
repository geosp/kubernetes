sudo snap install microk8s --classic
sudo snap alias microk8s.kubectl kubectl
microk8s enable dashboard dns ingress istio metallb metrics-server registry storage
microk8s kubectl expose deployment kubernetes-dashboard --type=LoadBalancer --name=kubernetes-dashboard-external --namespace=kube-system
microk8s kubectl expose deployment registry --type=LoadBalancer --name=registry-external --namespace=container-registry
microk8s kubectl get services --namespace=kube-system
microk8s kubectl get services --namespace=container-registry
token=$(microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s kubectl -n kube-system describe secret $token

# To change the cluster domain update the config map in the dashboard und the kube-system namespace 
# for CoreDNS to the new name and then update the /var/snap/microk8s/current/args/kubelet 
# and set --cluster-domain equal to your new domain name.
# get default gateway ip to cluster internal network for the main router to create a route to it.
# kubectl get svc istio-ingressgateway -n istio-system
