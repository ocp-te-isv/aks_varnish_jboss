# High Performance JBoss hosting in AKS, using Varnish, CDN and MySQL.

# Please note that this documentation is currently in progress, and as such should not be relied upon until complete! All content is subject to change.

## Overview

The solution will be hosted in Azure.
Static content will be hosted in Blob Storage.  
AKS will deliver services used for Web App and REST Api endpoints.  
Varnish caching will be used to reduce the number of requests to the Jboss application layer, and Redis will be used to reduce the number of requests to the MySQL DB layer.  
  
The initial setup will forego the CDN and Redis integration, which can be used to optimize the solution in later stages.  
Azure Kubernetes Service (AKS) will be used to host the varnish and jboss components.  

In a later stage, CDN will be used to offload requests for static content from the main cloud infrastructure.  

A typical setup would use an ingress controller via nginx:

![aks hierarchical overview](./images/aks_arc_overview.png)

However, we plan to optimize and simplify by using a WAF infront of the varnish cache, to save on the need for an ingress controller:

![aks hierarchical overview](./images/aks_arc_overview_2.png)

The architecture requires the following network configuration:

![solution network](./images/solution_networking_0.1.PNG)

You can use the following sections to get more information, they are designed to be followed in order:

## [Dependencies](./dependencies.md)

## [Setup of Pre-Requisites](pre-req_setup.md)

## [Preparing Docker Images](./docker_image_prep.md)

## [Setup of POC](poc_setup.md)

## [MySQL Configuration](./mysql_configuration.md)

## [Cleanup](./cleanup.md)


