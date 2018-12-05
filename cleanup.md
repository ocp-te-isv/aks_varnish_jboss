# Cleanup

The following steps need to be performed after load testing the system, if not deleting the entire Resource Group:

1.	WAF / App Gateway
Reduce the number of instances and SKU in the Azure Port.

2.	AKS
a.	Kubectl scale deployment –replicas=1 <deployment name for Wildfly>
b.	Kubectl scale deployment –replicas=1 <deployment name for Varnish>

c.	Using the Portal reduce the number of nodes in both AKS services

or using 

```shell
az aks scale
```

See:  
https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-scale

Also stop the VMs in the portal.

3.	MySQL

Reduce the number of CPUs in the portal to 2.

Or use 
```shell
az mysql server update –sku-name GP_Gen5_2
```
See:  
https://docs.microsoft.com/en-us/cli/azure/mysql/server?view=azure-cli-latest#az-mysql-server-update
