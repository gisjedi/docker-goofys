FROM webhippie/alpine:latest
MAINTAINER Thomas Boerger <thomas@webhippie.de>

VOLUME ["/share"]

WORKDIR /root
ENTRYPOINT ["/usr/bin/goofys"]

ENV GOOFYS_PATH github.com/kahing/goofys
ENV GOOFYS_REPO https://${GOOFYS_PATH}.git
ENV GOOFYS_BRANCH v0.0.6

ENV GOPATH /usr/local
ENV GO15VENDOREXPERIMENT 1

RUN apk update && \
  apk add \
    ca-certificates \
    fuse \
    build-base \
    go \
    git && \
  git clone \
    -b ${GOOFYS_BRANCH} \
    ${GOOFYS_REPO} \
    /usr/local/src/${GOOFYS_PATH} && \
  cd \
    /usr/local/src/${GOOFYS_PATH} && \
  go build \
    -o /usr/bin/goofys && \
  apk del \
    build-base \
    go \
    git && \
  rm -rf \
    /var/cache/apk/* \
    /usr/local/*
