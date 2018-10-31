# Tuning and Scaling AKS

Throughput and performance of the AKS nodes and application instances can be monitored via the metrics shown in the insights section, as well as in the logs if container logging is being used for metric evaluation.
These can be pinned to a dashboard for convenience during the POC:

![aks performance](./images/aks_performance.PNG)

AKS nodes and instances can be scaled separately.
In such a case, it is important that the limits for the containers are set in the helm charts to ensure that Kubernetes does not start too many instances on a single node.

![scale aks node](./images/scale_aks_nodes.PNG)

![scale aks instances](./images/scale_aks_instances.PNG)

