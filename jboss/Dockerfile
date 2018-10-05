FROM maven:3.5.3-jdk-10-slim AS build-env
WORKDIR /src/helloworld-rs
# lines 4 & 5 save us the effort of fetching the dependencies every time we update the app
COPY pom.xml /src/
COPY helloworld-rs/pom.xml /src/helloworld-rs/
RUN mvn verify clean --fail-never
# becuase of the jboss sample we are forced to do this with
# multiple pom.xml etc, what is neccessary in prod may be different

# Copies the remaining sources over for build
COPY . /src/
RUN mvn package

FROM jboss/wildfly:14.0.1.Final AS base
COPY --from=build-env /src/helloworld-rs/target/helloworld-rs.war /opt/jboss/wildfly/standalone/deployments/

