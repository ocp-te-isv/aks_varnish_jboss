#!/bin/bash
az login

# if you have multiple subscriptions, 
# and the one we need is not default use the following to set the
# correct subscription for AKS
# az account set --subscription <subscription id> 

AKS_RESOURCE_GROUP=AKS_POC
AKS_CLUSTER_NAME=WebAppPOC
ACR_RESOURCE_GROUP=AKS_POC
ACR_NAME=<your acr name here>

# Get the id of the service principal configured for AKS
CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)

# Get the ACR registry resource id
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)

# Create role assignment
az role assignment create --assignee $CLIENT_ID --role Reader --scope $ACR_ID