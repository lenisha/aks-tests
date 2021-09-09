# Tests with AppGtwy Ingress controller 

Reproducing the issue with ingress definition requiring `*` in the path with TWO simple apps
- ASPNET App with two pages / and /Privacy
- WebColor App with one colored page at /

## Test 1 with *

```yml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: aspnetapp
  annotations:
    kubernetes.io/ingress.class: azure/application-gateway
    appgw.ingress.kubernetes.io/backend-hostname: "localhost"
    appgw.ingress.kubernetes.io/backend-path-prefix: /
spec:
  rules:
  - http:
      paths:
      - path: /aspnet/*
        backend:
          serviceName: aspnetapp
          servicePort: 80
        pathType: Prefix 
      - path: /green
        backend:
          serviceName: webapp-color
          servicePort: 8080
        pathType: Prefix   
      - path: /
        backend:
          serviceName: webapp-red
          servicePort: 8080
        pathType: Prefix     
```

Test urls for the three sample apps deployed:

- http://20.94.33.60/aspnet/ - works only with last trailing slash added
- http://20.94.33.60/aspnet/Privacy - works only when path has `*` in it

- http://20.94.33.60/green  - green screen
- http://20.94.33.60/  - red screen


# Test 2 without *

```yml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: aspnetapp
  annotations:
    kubernetes.io/ingress.class: azure/application-gateway
    appgw.ingress.kubernetes.io/backend-hostname: "localhost"
    appgw.ingress.kubernetes.io/backend-path-prefix: /
spec:
  rules:
  - http:
      paths:
      - path: /aspnet
        backend:
          serviceName: aspnetapp
          servicePort: 80
        pathType: Prefix 
      - path: /green
        backend:
          serviceName: webapp-color
          servicePort: 8080
        pathType: Prefix   
      - path: /
        backend:
          serviceName: webapp-red
          servicePort: 8080
        pathType: Prefix     
```

- http://20.94.33.60/aspnet - works without need for trailing slash 
- http://20.94.33.60/aspnet/Privacy - 404 - doe not route properly to the app

- http://20.94.33.60/green  - green screen
- http://20.94.33.60/  - red screen
