FROM ubuntu:xenial-20201014
LABEL maintainer="Mithil.Patel@dell.com"

ENV SQUID_VERSION=3.5.12-1ubuntu7.8

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y squid=${SQUID_VERSION} && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["sbin/entrypoint.sh"]
