# Docker Image for Squid Proxy Server

pmithil7/squid:v1

## Introduction

This repo consists of a Dockerfile which is a container image for Squid proxy server. The aim of using Squid is to use it as a caching proxy for HTTP and HTTPS requests in order to reduce bandwidth and improve response times.

## Contents

This repo consists of a `Dockerfile`(Dockerfile) which is the main image. An `entrypoint.sh`(entrypoint.sh) which acts as how the container will run. A `docker-compose.yml`(docker-compose.yml) file if you want to run the server as a service.

We will preserve the cache of the squid container at `/var/spool/squid`.

## Installation

You can pull the image from DockerHub for now. We can move it to our Internal Dell Registry if needed.

```bash
docker pull pmithil7/squid:v1
```

You can also build the image.

```bash
docker build -t pmithil7/squid .
```

## How to Run

Squid is a very popular caching proxy server and there are several configuration parameters available. In order, to run this image along with your customized Squid configuration, we will mount the custom configuration file at `/etc/squid/squid.conf`.

Example:

```bash
docker run --name squid -d \
  --publish 3128:3128 \
  --volume /srv/docker/squid/cache:/var/spool/squid \
  --volume /home/mapatel/squid.conf:/etc/squid/squid.conf 
  pmithil7/squid:v1
```

Make sure you are configured to use this proxy server after running which would be available at `172.17.0.1:3128`

For bash, add the following in your `.bashrc` file.

```bash
export http_proxy=http://172.17.0.1:3128
export https_proxy=http://172.17.0.1:3128
```

In order to run this container as a service you can also use docker compose. When you are in this repo just run the below command in order to get the server up and running as a service.

```bash
docker-compose up -d
```

## Logs

You can access logs of the squid server which is located at `/var/log/squid` by the below command:

```bash
docker exec -it squid tail -f /var/log/squid/access.log
```

