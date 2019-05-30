# AKS Policies

Example Egress Policy whitelisting two REST services and DNS lookup - `deny-egress-whitelisted.yaml`

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-whitelist
  namespace: development
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  # KubeDNS for resolution
  - to: 
    ports:
    - port: 53
      protocol: UDP
    - port: 53
      protocol: TCP
  # https://samples.openweathermap.org/data/2.5/weather?q=London,uk
  - to:
    - ipBlock:
        cidr: 138.201.197.100/32
  # https://api.openfigi.com/schema
  - to: 
    - ipBlock:
        cidr: 69.191.255.166/32
    ports:
    - port: 443
      protocol: TCP    
```
This example policy applies to namespace "development" and all pods since `podselector: {}` is all inclusive.
It specifies egress rule to only allow DNS ports and two specific services


[AKS Network policies](https://docs.microsoft.com/en-us/azure/aks/use-network-policies)

[Network policies tutorial](https://github.com/ahmetb/kubernetes-network-policy-recipes)
