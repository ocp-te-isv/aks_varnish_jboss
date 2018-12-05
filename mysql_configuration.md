# MySQL Configuration

## Create MySQL DB

see also:  
https://docs.microsoft.com/en-us/cli/azure/mysql/server?view=azure-cli-latest#az-mysql-server-create

```shell
az mysql server create -l westeurope  --sku-name GP_Gen5_2 -g AKS_POC -n akspocmysql -u akspocadmin -p <super secret password here>
```

## VNet Mgmt:  
https://docs.microsoft.com/en-us/azure/mysql/howto-manage-vnet-using-cli


create a VNET rule
https://docs.microsoft.com/en-us/cli/azure/mysql/server/vnet-rule?view=azure-cli-latest#az-mysql-server-vnet-rule-create


## Scaling  
As scaling operations will cause DBs to drop clients we should scale DBs outside of main working hours.

Client code must implement retry logic for connections.

