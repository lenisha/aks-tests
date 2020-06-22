## Get System MI data 
az ad sp show --id f2acd1f2-c716-46cb-ab66-51f0bee3effb

# Get User identities
az identity list

# AAD
```
Enterprise application demoidentity appid: 0d6fd290-7c28-4ae2-88f4-78be54c0bab8
```

## Get Instance metadata
curl -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-08-01" | jq .

# Get Token for Keyvault

## https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/how-to-use-vm-token
curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net%2F' -H Metadata:true -s | jq .


## Get Token Parsed
```
response=$(curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true -s)
access_token=$(echo $response | python -c 'import sys, json; print (json.load(sys.stdin)["access_token"])')
echo The managed identities for Azure resources access token is $access_token
```

# Get Secret
curl 'https://akstests.vault.azure.net/secrets/testtoken/990e696afc194f2d9a61f1b6d6b4f8b9?api-version=7.0' -H 'Accept: application/json' -H "Authorization: Bearer ${access_token}"

# KUBE

# get bindings
k get azureidentity
k get azureidentitybinding
k get azureassignedidentity

# on MSI POD
curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net%2F' -H Metadata:true -s

# On NMI POD
```
wget  --header "podname: testmsi-74d689759d-8zrwm" --header "podns: default" -S  -O log   http://127.0.0.1:2579/host/token/?resource=https%3A%2F%2Fvault.azure.net%0A
```

# CREATE identity setup
export SUBSCRIPTION_ID="f869415f-5cff-46a3-b728-20659d14d62d"
export RESOURCE_GROUP="aks"
export IDENTITY_NAME="demomi"
az identity create -g $RESOURCE_GROUP -n $IDENTITY_NAME --subscription $SUBSCRIPTION_ID
export IDENTITY_CLIENT_ID="$(az identity show -g $RESOURCE_GROUP -n $IDENTITY_NAME --subscription $SUBSCRIPTION_ID --query clientId -otsv)"
export IDENTITY_RESOURCE_ID="$(az identity show -g $RESOURCE_GROUP -n $IDENTITY_NAME --subscription $SUBSCRIPTION_ID --query id -otsv)"
export IDENTITY_ASSIGNMENT_ID="$(az role assignment create --role Reader --assignee $IDENTITY_CLIENT_ID --scope /subscriptions/$SUBSCRIPTION_ID/resourceGroups/$RESOURCE_GROUP --query id -otsv)"

```
az aks show -g aks -n aksEnerosMSIv2  | grep clientId
az role assignment create --role "Managed Identity Operator" --assignee e2e9dcb9-3aa2-4846-b6ac-433c0be1274d --scope /subscriptions/f869415f-5cff-46a3-b728-20659d14d62d/resourcegroups/aks/providers/Microsoft.ManagedIdentity/userAssignedIdentities/demomi

az role assignment create --role Contributor --assignee fd72f9f1-6758-410c-9441-dac68276c187 --scope /subscriptions/$SUBSCRIPTION_ID/resourceGroups/MC_aks_aksEnerosMSIv2_westus --query id -otsv
```

### SQL
CREATE USER "jumpy" from external provider;
ALTER ROLE db_datareader ADD MEMBER "jumpy"