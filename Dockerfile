# Dockerfile to build ProxPush
# ProxPush is a proxy to allow Prometheus to scrape through NAT etc.

FROM golang:alpine
MAINTAINER Anthony Rogliano <aroglian@cisco.com>
LABEL Description="ProxPush docker image"

RUN apk update \
  && apk upgrade \
  && apk add --no-cache \
         git

RUN mkdir -p /proxpush

WORKDIR /proxpush

RUN cd /proxpush \
  && go get github.com/robustperception/pushprox/proxy \
  && apk del git \
  && cd /go/src/github.com/robustperception/pushprox/proxy \
  && go build

CMD exec /go/bin/proxy
