## Setup Procedure
Run the following commands in a shell which has the Azure CLI available.

```shell
# Login to Azure with the CLI
az login

# Create a resource group in which we will place the components to be used in the POC
az group create --name AKS_POC --location WestEurope

# Create an Azure Container Registry for publishing and to store our images
az acr create --name akspoc --resource-group AKS_POC --sku Basic

# Create an AKS Cluster, with node count of 1 (as this is the initial configuration for POC) node type and count can be adjusted as needed. RBAC is enabled by default.
az aks create --resource-group AKS_POC --name WebAppPOC --node-count 1 --enable-addons monitoring
```

Azure will take a little while to provision all the required resources:

![waiting for AKS provisioning](./images/aks_create_waiting.png)

When finished, you can use the following command to create a local entry on your client that can be used to automatically log into the AKS env:
```shell
az aks get-credentials -g AKS_POC -n WebAppPOC
```

to verify that the nodes are online and running, using the following command:
```shell
kubectl get nodes
```
