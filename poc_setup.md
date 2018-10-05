## Setup Procedure

Here we prepare the clound environment in which we shall be running the POC.  
We shall setup the various components to host the web apps and assocaited storage and caches.  

### Step 1 - Create the first resources

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

### Step 2 - Configure AKS creds & validate

When finished, you can use the following command to create a local entry on your client that can be used to automatically log into the AKS env:
```shell
az aks get-credentials -g AKS_POC -n WebAppPOC
```
You will see the resulting output indicating that the credentials are merged into a local credentials file:
![AKS cred merge](./images/aks_get_credentials.png)

to verify that the nodes are online and running, using the following command:
```shell
kubectl get nodes
```

### Step 3 - Prepare and publish docker images

Now, if you have not already done so, go [here](./docker_prep.md) to prepare and publish your docker images.

### Step 4 - Prepare the helm charts

