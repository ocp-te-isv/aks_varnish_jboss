## Dependencies

Information on the dependencies for running the POC is given here.

The setup section will take you through getting everything installed and working.

### Azure CLI
Azure CLI helps us script and interact with Azure via the command line.  
The setup could also be done via the Azure Portal, but we chose Azure CLI to make the steps used in the POC easier to follow, more repeatable, with minimum chance for error, and maximum automation.  
[https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)

### AKS
Azure Kubernetes Service (AKS) provides the clustering, and container orchestration services for the Varnish and Jboss components.  
It also helps automate the setup and configuration of some of the load balancing.  

### ACR
Azure Container Registry (ACR), provides the storage services in which we place container images which are used by AKS to run our services in the cluster.  
Once the appropriate extensions have been installed, we can push our container images to the private registry in Azure, and give our AKS service account rights to read images from the registry to create our containers.  

### Kubectl
Used to control AKS from the command line, is installed duing AKS setup with the shell command

### HELM
[Helm](https://helm.sh)) is a package manager, that helps you manage Kubernetes applications — Helm Charts help you define, install, and upgrade your Kubernetes applications.  
On Windows 10 (yes I work for Microsoft and still use Windows 10, with Linux subsystem), but you are welcome to use Linux, Mac OS or whatever you like to set us up the cloud.  
We used [Chocolatey](https://chocolatey.org/docs/installation) to install helm, via following shell command:

```shell
choco install kubernetes-helm
```

