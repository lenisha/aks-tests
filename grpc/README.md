# GRPC Applisations on AKS

## Install Nginx Ingress

### Install with manifests
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/cloud-generic.yaml
```

### Verify installation

```
kubectl get pods --all-namespaces -l app.kubernetes.io/name=ingress-nginx --watch
watch kubectl get services -n ingress-nginx
```

### Nginx version check

```
POD_NAMESPACE=ingress-nginx
POD_NAME=$(kubectl get pods -n $POD_NAMESPACE -l app.kubernetes.io/name=ingress-nginx -o jsonpath='{.items[0].metadata.name}')
kubectl exec -it $POD_NAME -n $POD_NAMESPACE -- /nginx-ingress-controller --version
```
### Add SSL cert for ingress

```
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=l6.altostratus.me/O=nginxsvc"
kubectl create secret tls tls-secret --key tls.key --cert tls.crt
```

## Install GRPC Applications and test

### Install grpc Applications

```
kubectl apply -f grpc-app.yaml
kubectl apply -f grpc-svc.yaml
kubectl apply -f grpc-ingress.yaml

kubectl apply -f grpc-app2.yaml
kubectl apply -f grpc-svc2.yaml
kubectl apply -f grpc-ingess2.yaml
```

### Test GRPC with grpcurl

```
$ grpcurl -insecure -authority=svc2.l6.altostratus.me l6.altostratus.me:443 build.stack.fortune.FortuneTeller.Predict
$ grpcurl -insecure l6.altostratus.me:443 build.stack.fortune.FortuneTeller.Predict
```


### References
[Nginx-grpc](https://github.com/kubernetes/ingress-nginx/tree/master/docs/examples/grpc)
[Nginx-azure install guide](https://kubernetes.github.io/ingress-nginx/deploy/#azure)
[External DNS](https://github.com/kubernetes-incubator/external-dns/blob/master/docs/tutorials/azure.md)
[Azure Nginx Ingress guide](https://docs.microsoft.com/en-us/azure/aks/ingress-own-tls)