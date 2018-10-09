# Powershell script to create network resources for Web Application Firewall
az login

$RGName = "AKS_POC"

az network vnet create --name pocVNet --resource-group $RGName --location westeurope --address-prefix 10.0.0.0/16 --subnet-name gatewaySubnet --subnet-prefix 10.0.1.0/24

az network vnet subnet create --name backendSubnet --resource-group $RGName --vnet-name pocVNet --address-prefix 10.0.2.0/24

az network public-ip create --resource-group $RGName --name gatewayPublicIPAddress