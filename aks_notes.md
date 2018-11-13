Notes:

Don't forget to save those RSA / SSH keys when you create an AKS cluster for the first time.  

Multiple Node Pool support:  
https://github.com/Azure/AKS/issues/287

Advanced AKS Networking (Install AKS into a subnet):  
https://docs.microsoft.com/en-us/azure/aks/configure-advanced-networking


When viewing the ACL on the Azure CR, if you go too deep into the ACL, if you delete, it will delete the service principal, and not just the ACE from the ACL.

See also:  
https://docs.microsoft.com/en-us/azure/aks/kubernetes-service-principal

Be sure to set memory limits for the Java VM POD instances

Be sure to set the Java VM Heap Opts for the Java VM (-Xmx<desired limit in Mb>m)

see also https://developers.redhat.com/blog/2017/03/14/java-inside-docker/
