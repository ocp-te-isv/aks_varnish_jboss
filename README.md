# High Performance JBoss / Wildfly hosting in AKS, using Varnish, CDN and MySQL.

## Please note that this documentation an performance testing is currently in progress, and as such should not be relied upon until complete! All content is subject to change.

## Overview

The solution will be hosted in Azure.
Static content will be hosted in Blob Storage.  

We are using AKS to offer long term flexibility for development and easier management of software updates, which currently have a cadence of a few per month, but are expected to increase as the engineering teams get more familiar with the use of Azureand containerized DevOps.  

AKS will deliver services used for Web App and REST Api endpoints.  
Varnish caching will be used to reduce the number of requests to the Jboss application layer, and Redis could offer a future performance enhancement for the MySQL DB layer.  
  
The initial setup will forego the CDN and Redis integration, which can be used to optimize the solution in later stages.  
Azure Kubernetes Service (AKS) will be used to host the varnish and jboss components.  

In a later stage, CDN will be used to offload requests for static content from the main cloud infrastructure.  

A typical setup would use an ingress controller via nginx:

![aks hierarchical overview](./images/aks_arc_overview.png)

However, we plan to optimize and simplify by using a WAF infront of the varnish cache, to save on the need for an ingress controller:

![aks hierarchical overview](./images/aks_arc_overview_2.png)

The initial concept had the following network configuration:

![solution network](./images/solution_networking_0.1.PNG)


However, after following up with MySQL engineering and the initial performance tests, a single Azure DB for MySQL was used, which was scaled to 16 or 32 Cores, depending on the peak load requirements.

![solution perf 1](./images/aks_arc_perf_test_step1.PNG)


The following describes the architecture we tested in more detail and any learnings:

## [POC Architecture](poc_architecture.md)

You can use the following sections to get more information, they are designed to be followed in order:

## [Dependencies](./dependencies.md)

## [Setup of Pre-Requisites](pre-req_setup.md)

## [Why CDN?](why_cdn.md)

## [Preparing Docker Images](./docker_image_prep.md)

## [Setup of POC](poc_setup.md)

## [WAF Setup](waf_setup.md)

## [MySQL Configuration](./mysql_configuration.md)

## [Monitoring & scaling during the POC](monitoring_scaling.md)

## [Cleanup](./cleanup.md)


