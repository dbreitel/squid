#!/bin/bash
set -e

chmod -R 755 /var/spool/squid
chown -R proxy:proxy /var/spool/squid

# Arguments to pass to squid
if [[ $1 =~ ^- ]]; then
  EXTRA_ARGS="$@"
  set --
elif [[ ${1} == squid || ${1} == $(which squid) ]]; then
  EXTRA_ARGS="${@:2}"
  set --
fi


# Launch squid
if [[ -z ${1} ]]; then
  if [[ ! -d /var/spool/squid/00 ]]; then
    echo "Creating swap directories"
    $(which squid) -Nz
  fi
  echo "Starting squid"
  exec $(which squid) -f /etc/squid/squid.conf -CNYd 1 ${EXTRA_ARGS}
else
  exec "$@"
fi
