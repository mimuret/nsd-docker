#!/bin/ash

export NSD_IDENTITY=${NSD_IDENTITY:-`hostname`}

if [ ! -e "etc/nsd/nsd_server.key" ] ; then
  /nsd/sbin/nsd-control-setup
fi

envsubst < /etc/nsd/nsd.conf.tpl > /etc/nsd/nsd.conf && cat /etc/nsd/nsd.conf
exec "$@"