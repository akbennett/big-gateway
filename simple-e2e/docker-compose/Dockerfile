FROM alpine

RUN apk add --no-cache curl ca-certificates docker

RUN curl -L --fail https://github.com/docker/compose/releases/download/1.20.1/run.sh -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

COPY *.yml /
