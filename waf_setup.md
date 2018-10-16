# WAF SETUP

We shall use steps from the following article:  

https://docs.microsoft.com/en-us/azure/application-gateway/create-ssl-portal

The WAF is created and prepared by our setup script in the following section:

```shell
# Create the Network and Subnets
az network vnet create --name pocVNet --resource-group AKS_POC --location westeurope --address-prefix 10.1.0.0/16 --subnet-name gatewaySubnet --subnet-prefix 10.1.1.0/24

az network vnet subnet create --name aksSubnet --resource-group AKS_POC --vnet-name pocVNet --address-prefix 10.1.2.0/24

az network public-ip create --resource-group AKS_POC --name gatewayPublicIPAddress

az network application-gateway create --resource-group AKS_POC --name akswaf --sku WAF_Large --subnet gatewaySubnet --vnet-name pocVNet --public-ip-address gatewayPublicIPAddress

# store the network object for later (this is powershell)
$network = az network vnet subnet list --resource-group AKS_POC --vnet-name pocVnet --query [].id --output tsv | sls backend | select -exp line
```
## Certificate

To create a self-signed certificate to use for a POC or testing, use the following steps on a Windows PC.
Replace **\<angle brackets and text\>** with appropriate entries that suit you:

1. Start Powershell as Admin
2. Run the following command. If you do not have rights to a DNS namespace, use a name that you can configure in your testing machine's hosts file.

```powershell
New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname aks.<yourdomainname here>
```

3. Then export the certificate using:

```powershell
$pwd = ConvertTo-SecureString -String "<your password here>" -Force -AsPlainText
Export-PfxCertificate \
  -cert cert:\localMachine\my\<your certificate thumbprint here> \
  -FilePath c:\appgwcert.pfx \
  -Password $pwd
```

## WAF Listener

To create the HTTPS listener, which will use the certificate created above, we run the following commands (assuming that you include this in a setup script or have already run "az login"):

```shell
# register a cert for use on the App gateway / WAF 
az network application-gateway ssl-cert create -g AKS_POC --gateway-name akswaf -n AksCert --cert-file \path\to\cert\file --cert-password <your password>

# create Http settings for HTTPS Frontend listener
az network application-gateway http-settings create -g AKS_POC --gateway-name akswaf -n AksWafHttpsSettings --port 443 --protocol Https --cookie-based-affinity Disabled --timeout 30

# create Http settings for HTTP Backend pool (SSL Offload)
az network application-gateway http-settings create -g AKS_POC --gateway-name akswaf -n BackendHttpSettings --port 80 --protocol Http --cookie-based-affinity Disabled --timeout 30

# create an HTTPS frontend port on the gateway to register with the listener
az network application-gateway frontend-port create -g AKS_POC --gateway-name akswaf -n HttpsPort --port 443

# create an HTTPs Listener to use the cert created above
az network application-gateway http-listener create --frontend-ip appGatewayFrontendIP --frontend-port HttpsPort --gateway-name akswaf --resource-group AKS_POC --name appGatewayHttpsListener --ssl-cert AksCert

#create a backend address pool
az network application-gateway address-pool create -g AKS_POC --gateway-name akswaf -n AksLBAddressPool --servers 10.0.2.35

# create a rule to route traffic to AKS
az network application-gateway rule create -g AKS_POC --gateway-name akswaf -n RouteForAks --http-listener appGatewayHttpsListener --rule-type Basic --http-settings AksWafHttpsSettings --address-pool AksLBAddressPool
```
