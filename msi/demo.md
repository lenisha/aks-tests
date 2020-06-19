## Get System MI data 
az ad sp show --id f2acd1f2-c716-46cb-ab66-51f0bee3effb

# Get User identities
az identity list

## Get Instance metadata
curl -H Metadata:true "http://169.254.169.254/metadata/instance?api-version=2017-08-01" | jq .

# Get Token for Keyvault
## https://docs.microsoft.com/en-us/azure/active-directory/managed-identities-azure-resources/how-to-use-vm-token
azureuser@jumpy:~/aks-tests/msi$ curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net%2F' -H Metadata:true -s | jq .


## Get Token Parsed
```
response=$(curl 'http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https%3A%2F%2Fvault.azure.net' -H Metadata:true -s)
access_token=$(echo $response | python -c 'import sys, json; print (json.load(sys.stdin)["access_token"])')
echo The managed identities for Azure resources access token is $access_token
```

# Get Secret
curl 'https://akstests.vault.azure.net/secrets/testtoken/990e696afc194f2d9a61f1b6d6b4f8b9?api-version=7.0' -H 'Accept: application/json' -H "Authorization: Bearer ${access_token}"



### SQL
CREATE USER "jumpy" from external provider;
ALTER ROLE db_datareader ADD MEMBER "jumpy"