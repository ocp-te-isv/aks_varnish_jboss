# Note: this is powershell

#!/bin/bash

# Change these four parameters
$AKS_PERS_STORAGE_ACCOUNT_NAME = "akspocstorageaccount"
$AKS_PERS_RESOURCE_GROUP = "AKS_POC"
$AKS_PERS_LOCATION = "WestEurope"
$AKS_PERS_SHARE_NAME = "aksshare"

# Create the storage account
az storage account create -n $AKS_PERS_STORAGE_ACCOUNT_NAME -g $AKS_PERS_RESOURCE_GROUP -l $AKS_PERS_LOCATION --sku Standard_LRS

# Export the connection string as an environment variable, this is used when creating the Azure file share
$Env:AZURE_STORAGE_CONNECTION_STRING =(az storage account show-connection-string -n $AKS_PERS_STORAGE_ACCOUNT_NAME -g $AKS_PERS_RESOURCE_GROUP -o tsv)

# Create the file share
az storage share create -n $AKS_PERS_SHARE_NAME

# Get storage account key
$STORAGE_KEY=$(az storage account keys list --resource-group $AKS_PERS_RESOURCE_GROUP --account-name $AKS_PERS_STORAGE_ACCOUNT_NAME --query "[0].value" -o tsv)

# Echo storage account name and key
echo "Storage account name:" $AKS_PERS_STORAGE_ACCOUNT_NAME
echo "Storage account key:" $STORAGE_KEY

# now create the AKS secret for access to the share

kubectl create secret generic azure-secret --from-literal=azurestorageaccountname=$AKS_PERS_STORAGE_ACCOUNT_NAME --from-literal=azurestorageaccountkey=$STORAGE_KEY