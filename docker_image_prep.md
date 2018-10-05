Docker Image Preparation

JBOSS

The Jboss image is derived from the Wildfly samples found here.  
These are provided under an Apache License.  
[https://github.com/wildfly/quickstart/tree/master/helloworld-rs](https://github.com/wildfly/quickstart/tree/master/helloworld-rs)

You can create the docker image from the ./jboss folder by running:

```shell
docker build -t jboss:v0.1 .
```

then once built, you can push to the Azure Container Registry by doing the following:

```shell
# login to azure container registry
az acr login --name akspoc

# update image with tag for azure container registry
docker tag jboss:v0.1 akspoc.azurecr.io/jboss:v0.1

# push image to azure container registry
docker push akspoc.azurecr.io/jboss:v0.1
```


Details of the changes are described below:



VARNISH

The Varnish cache images are taken from [https://hub.docker.com/r/million12/varnish/](https://hub.docker.com/r/million12/varnish/).

