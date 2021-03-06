# POC Architecture

## Vnet

A vnet will be used to isolate systems from the internet and a WAF will be placed in the gateway subnet to protect the application layers.

## Firewall layer

1 x WAF_Large for off_peak  
to scale up to 8 - 10 instances during peak load

## AKS Varnish

Following some investigation, it was deemed that the 4 Varnish servers currently in use in the data center could be replaced by 2 single instances for Peak load and fault tolerance. 

Based on the current differences in performance characteristics and node size, varnish instances currently need to be housed in their own AKS cluster (AKS nodepools currently only support a single VM node size) or on dedicated VMs.

Current sizes which are being considered to achieve peak performance:

- Standard_M8ms  
- Standard_M16ms

## AKS Wildfly

Wildfly instances are planned to be run with 4 vCores and 4 GB RAM, at a concentration of 3 instances per AKS node.  
The assumption is that the majority of load measured on the hardware instances was related to the MySQL traffic, which was co-hosted with 4 Wildfly instances.  

Current tests showed sufficient performance with 9 wildfly instances across 3 Nodes in the AKS Service for peak load.

This assumption is being further validated in the application performance tests.

Due to other services running on the servers, we will likely need more than 16 GB.

Depending on the results of performance testing, options for AKS Node sizes are potentially:

- Standard_D16_v3	
- Standard_F8s_v2
- Standard_F16s_v2

Larger VM sizes ensure that the required disk and network IO is available. 

## MySQL

The initial sizing of MySQL forsees trying to host with 1 Azure DB for MySQL Gen5 using scheduled scaling for peak and offpeak workloads.

Current DB Size is 800GB with a growth rate of potentially 10 - 25 % per year.

Peak CPU to scale out to 32 Cores, offpeak to 4.

Options to increase performance by using MySQL replication and read only instances are held in reserve.

Current testing shows that a single Azure DB for MySQL is enough to handle the peak load.

## Future Optimizations

### Azure Storage & CDN

Static content and images can be hosted in Azure storage using Verizon or Akamai CDN, to reduce the amount of cache memory in use on the varnish cache and egress trafic from the deployment / Azure region. 

During testing, we found that the standard Azure files did not provide enough throughput for the WildFly instances when they scaled, as there is no caching of the images currently implemented.

As we were testing in West Europe, we were unable to create a Premium Azure Files storage account to improve storage bottlenecks when the number of WildFly instances were scaled up.

The Standard azure files storage is currently adding around 350 ms latency to image retrieval requests.  
This in turn is reducing the serial request processing, requiring a system which supports a higher rate of concurrency in HTTP request processing.

### Redis Cache

Potentially, calls to the MySQL database can be cached in an object store like Redis to reduce calls to the database and the need to scale up the number of VCores.

This performance enhancement could be shared across all WildFly instances and could be preloaded to reduce any artifacts from sudden spikes in traffic, upgrades or restarting systems.
