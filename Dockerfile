FROM enovacom-docker:81/docker-nodejs-python:v8.11.2

MAINTAINER Maik Hummel <m@ikhummel.com>

WORKDIR /opt

ENV GH_CLIENT_ID=null \
    GH_CLIENT_SECRET=null \
    INFOSITE="http://shields.io"

RUN apt-get update && apt-get install -y pkg-config libcairo2-dev git gettext imagemagick
RUN git clone https://laurenttrk@github.com/laurenttrk/shields.git && cd shields && \
    npm i

COPY secret.tpl.json ./shields/

CMD envsubst < shields/secret.tpl.json > shields/secret.json && cd shields && git pull && node server.js

EXPOSE 80
