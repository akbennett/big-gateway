FROM alpine:latest

RUN apk add --no-cache wget openjdk8-jre-base ca-certificates

MAINTAINER Michael Scott "michael@opensourcefoundries.com"
# Californium proxe code located at: 
# https://github.com/OpenSourceFoundries/californium/commits/osf-2.0.x

RUN mkdir -p /opt/cf-proxy
COPY Californium.properties /opt/cf-proxy
COPY ProxyMapping.properties /opt/cf-proxy
COPY Proxy.properties /opt/cf-proxy
COPY cf-proxy-2.0.0-SNAPSHOT.jar /opt/cf-proxy

EXPOSE 5682

CMD cd /opt/cf-proxy && java -jar californium-proxy-2.0.0-M9.jar
