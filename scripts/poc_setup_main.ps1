# Powershell setup script for POC

# Login to Azure with the CLI
az login

# Create a resource group in which we will place the components to be used in the POC
az group create --name AKS_POC --location WestEurope

# Create the Network and Subnets
az network vnet create --name pocVNet --resource-group AKS_POC --location westeurope --address-prefix 10.1.0.0/16 --subnet-name gatewaySubnet --subnet-prefix 10.1.1.0/24

az network vnet subnet create --name aksSubnet --resource-group AKS_POC --vnet-name pocVNet --address-prefix 10.1.2.0/24

az network public-ip create --resource-group AKS_POC --name gatewayPublicIPAddress

az network application-gateway create --resource-group AKS_POC --name akswaf --sku WAF_Large --subnet gatewaySubnet --vnet-name pocVNet --public-ip-address gatewayPublicIPAddress

# store the network object for later (this is powershell)
$network = az network vnet subnet list --resource-group AKS_POC --vnet-name pocVnet --query [].id --output tsv | sls aksSubnet | select -exp line

# Create an Azure Container Registry for publishing and to store our images
az acr create --name akspoc --resource-group AKS_POC --sku Basic

# Create an AKS Cluster, with node count of 1 (as this is the initial configuration for POC) node type and count can be adjusted as needed. RBAC is enabled by default.
az aks create --resource-group AKS_POC --name WebAppPOC --network-plugin azure --vnet-subnet-id $network --docker-bridge-address 172.17.0.1/16 --dns-service-ip 10.2.0.10 --service-cidr 10.2.0.0/24 --node-count 1 --enable-addons monitoring

