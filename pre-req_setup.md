## Pre-Requisite / Dependency Setup Procedures
The pre-requisites should be installed in the following order:  
### Azure
We will need to create resource groups and the various services required to host the solution in Azure.  
Ensure that you have access to an Azure Subscription with Contributor rights:  
[https://portal.azure.com](https://portal.azure.com)  
### Azure CLI
Install Azure CLI  
[https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)  
### Kubectl
Install Kubectl.  
Once Azure CLI is installed, uise the following command to install kubectl:  
```shell
# Installs AKS CLI, downloads kubectl client
az aks install-cli
```
Afterwards, your env / path must be updated with the path to kubectl, the output of the install command will provide details of the correct path.  
### Helm
Using chocolately, or the installer of your choice, install Helm.
We use Chocolatey (from an elevated shell session) to install Helm:  
```shell
choco install kubernetes-helm
```
 