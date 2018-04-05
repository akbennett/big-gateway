FROM alpine:latest

RUN apk add --no-cache wget openjdk8-jre-base ca-certificates

MAINTAINER Michael Scott "michael@opensourcefoundries.com"
# Downloaded from: http://central.maven.org/maven2/org/eclipse/californium/californium-proxy/2.0.0-M9/

RUN mkdir -p /opt/cf-proxy
COPY Californium.properties /opt/cf-proxy
COPY ProxyMapping.properties /opt/cf-proxy
COPY Proxy.properties /opt/cf-proxy
COPY californium-proxy-2.0.0-M9.jar /opt/cf-proxy

EXPOSE 5682

CMD cd /opt/cf-proxy && java -jar californium-proxy-2.0.0-M9.jar
