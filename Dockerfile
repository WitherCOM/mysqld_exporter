ARG ARCH="amd64"
ARG OS="linux"

FROM golang:1.21 as builder
COPY . /build
WORKDIR /build
RUN go build

FROM quay.io/prometheus/busybox-${OS}-${ARCH}:latest
LABEL maintainer="The Prometheus Authors <prometheus-developers@googlegroups.com>"

ARG ARCH="amd64"
ARG OS="linux"
COPY --from=builder /build/mysqld_exporter /bin/mysqld_exporter 

EXPOSE      9104
ENTRYPOINT  [ "/bin/mysqld_exporter" ]
