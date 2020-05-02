sudo snap install microk8s --classic
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
su - $USER
sudo snap alias microk8s.kubectl kubectl
microk8s status --wait-ready
microk8s enable dashboard dns ingress istio metallb metrics-server registry storage
microk8s status --wait-ready
# The service kubernetes-dashboard-external will have be the IP address to connect to the dashboard.
kubectl expose deployment kubernetes-dashboard --type=LoadBalancer --name=kubernetes-dashboard-external --namespace=kube-system
# The service registry-external will have be the IP address to connect to the pricvate docker registry.
kubectl expose deployment registry --type=LoadBalancer --name=registry-external --namespace=container-registry
kubectl get services --namespace=kube-system
kubectl get services --namespace=container-registry
# This is the token you can use to access the dashboard.
token=$(kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
kubectl -n kube-system describe secret $token

# To change the cluster domain update the config map in the dashboard under the kube-system namespace 
# for CoreDNS to the new name and then update the /var/snap/microk8s/current/args/kubelet 
# and set --cluster-domain equal to your new domain name. To route requests form your LAN to the cluster internal
# network get default gateway IP using th folloeing command:
#
# kubectl get svc istio-ingressgateway -n istio-system
#
# On your LAN router create aroute to the cluster's gateway IP. You can install dnsmasq DNS server an use it as you
# LAN DNS and your main DHCP server. Devide your IP network into three ranges one for servers, one for DHCP clients, and 
# another one for external cluster services. If you have to connect to a VPN from your workstation us dnsmasq to forward
# DNS requests based on your domain name. If you want to expose cluster services to the internet select a cluster node
# as your DMZ server, deploy services to that node, and create ingress configurations for those external services. Make
# sure to enable the firewall setting on the DMZ server and only allow traffic to the ports required by your services.
# Ingress enables you to route requests using NGINX as the remote proxy using domain names.
