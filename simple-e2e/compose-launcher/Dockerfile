FROM alpine

RUN apk add --no-cache python3-dev py3-pip docker git bash curl
RUN pip3 install --upgrade pip docker-compose
COPY *.yml /

ENTRYPOINT ["/usr/bin/docker-compose"]
CMD "ACCOUNT=$ACCOUNT /usr/bin/docker-compose", /$LAUNCHER, "up"
