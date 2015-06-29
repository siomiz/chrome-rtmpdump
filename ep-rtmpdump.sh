#!/bin/bash
set -e

iptables -t nat -A OUTPUT -p tcp --dport 1935 -m owner \! --uid-owner root -j REDIRECT

mkdir -p /media/storage

cat <<- E > /etc/supervisor/conf.d/supervisord-crdonly.conf

	[program:rtmpsrv]
	environment=LD_LIBRARY_PATH=/usr/local/lib
	directory=/media/storage
	command=/usr/local/sbin/rtmpsrv
	user=root
	autorestart=true
	priority=100

E

exec "$@"
