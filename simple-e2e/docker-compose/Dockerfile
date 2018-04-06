FROM alpine

#RUN apk add --no-cache docker curl ca-certificates

#RUN curl -L --fail https://github.com/docker/compose/releases/download/1.20.1/run.sh -o /usr/local/bin/docker-compose
#RUN chmod +x /usr/local/bin/docker-compose


RUN apk add --no-cache py-pip docker git bash curl

RUN pip install docker-compose

COPY run.sh /usr/bin/run.sh

RUN chmod +x /usr/bin/run.sh

ENTRYPOINT ["/usr/bin/run.sh"]

COPY *.yml /
