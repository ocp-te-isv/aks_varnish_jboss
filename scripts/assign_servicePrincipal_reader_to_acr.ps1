#!/bin/bash
az login

$AKS_RESOURCE_GROUP = "AKS_POC"
$AKS_CLUSTER_NAME = "WebAppPOC2"
$ACR_RESOURCE_GROUP = "AKS_POC"
$ACR_NAME = "akspoc"

# Get the id of the service principal configured for AKS
$CLIENT_ID = (az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)

# Get the ACR registry resource id
$ACR_ID = (az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)

# Create role assignment
az role assignment create --assignee $CLIENT_ID --role Reader --scope $ACR_ID