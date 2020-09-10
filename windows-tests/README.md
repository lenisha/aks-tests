## test windows containers

- Build image

```
az acr build --image hellowinaspnet --registry acraccess --resource-group aks-tests --file Dockerfile --platform windows .
```
- Deploy manifest `winpod.yaml` with selector for windows nodes

```
 nodeSelector: 
    kubernetes.io/os: windows
```

- Verify installed certs on the pod

```
> kubectl exec -it hellowindows -- powershell Get-ChildItem Cert:\\LocalMachine\\Root -Verbose

 PSParentPath: Microsoft.PowerShell.Security\Certificate::LocalMachine\Root

Thumbprint                                Subject
----------                                -------
DD47BFA8CC8F94AE5CC33914C5C10D8DEE748C99  CN=DO_NOT_TRUST_FiddlerRoot, O=DO_NOT_TRUST, OU=Created by http://www.fiddler2.com
CDD4EEAE6000AC7F40C3802C171E30148030C072  CN=Microsoft Root Certificate Authority, DC=microsoft, DC=com
BE36A4562FB2EE05DBB3D32323ADF445084ED656  CN=Thawte Timestamping CA, OU=Thawte Certification, O=Thawte, L=Durbanville, S=Western Cape, C=ZA      
A43489159A520F0D93D032CCAF37E7FE20A8B419  CN=Microsoft Root Authority, OU=Microsoft Corporation, OU=Copyright (c) 1997 Microsoft Corp.
92B46C76E13054E104F230517E6E504D43AB10B5  CN=Symantec Enterprise Mobile Root for Microsoft, O=Symantec Corporation, C=US
8F43288AD272F3103B6F

```