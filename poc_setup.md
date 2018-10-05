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

### Step 3 - Initialize Helm

In order to use Helm, we need to initialize it.  
Before that, we need to create a service account for helm to use called "tiller".  

Assuming you have cloned this repo, use the following command to create the tiller account:

```shell
kubectl create -f ./aks_setup_yaml_files/rbac.yaml
```

This should result in the account being added in the cluster role bindings:  

![kubectl tiller](./images/kubectl_tiller_create.png)

This will allow us to use the helm charts to publish services and configure AKS.  
We then initialize Helm on our local system, to use this tiller account with:

```shell
helm init --service-account tiller
```

Resulting in

![helm init](./images/helm_init.png)

### Step 3 - Prepare and publish docker images

Now, if you have not already done so, go [here](./docker_prep.md) to prepare and publish your docker images.

### Step 4 - Prepare the helm charts

