FROM alpine

#RUN apk add --no-cache docker curl ca-certificates

#RUN curl -L --fail https://github.com/docker/compose/releases/download/1.20.1/run.sh -o /usr/local/bin/docker-compose
#RUN chmod +x /usr/local/bin/docker-compose

RUN apk add --no-cache python3-dev py3-pip docker git bash curl
RUN pip3 install --upgrade pip docker-compose
COPY *.yml /

ENTRYPOINT ["/usr/bin/docker-compose"]

#https://download.docker.com/linux/static/stable/x86_64/docker-18.03.0-ce.tgz
#FROM python:3.6

#RUN set -ex; \
#    apt-get update -qq; \
#    apt-get install -y \
#        locales \
#        curl \
#        python-dev \
#        git

#RUN apk add --no-cache curl shadow python3-dev py3-pip git ca-certificates

#RUN curl -fsSL -o dockerbins.tgz "https://download.docker.com/linux/static/stable/x86_64/docker-18.03.0-ce.tgz" && \
#    SHA256=e5dff6245172081dbf14285dafe4dede761f8bc1750310156b89928dbf56a9ee; \
#    echo "${SHA256}  dockerbins.tgz" | sha256sum -c - && \
#    tar xvf dockerbins.tgz docker/docker --strip-components 1 && \
#    mv docker /usr/local/bin/docker && \
#    chmod +x /usr/local/bin/docker && \
#    rm dockerbins.tgz
