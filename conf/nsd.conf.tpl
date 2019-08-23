server:
	do-ip4: ${NSD_DO_IPV4}
	do-ip6: ${NSD_DO_IPV6}
	username: "daemon"
	server-count: 1
	verbosity: ${NSD_VERBOSITY}
	database: ""
	logfile: "/var/log/nsd.log"
	hide-version: ${NSD_HIDE_VERSION}
	hide-identity: ${NSD_HIDE_IDENTITY}
	identity: "${NSD_IDENTITY}"
	tcp-count: ${NSD_TCP_COUNT}
	ipv4-edns-size: ${NSD_IPV4_EDNS_SIZE}
	ipv6-edns-size: ${NSD_IPV6_EDNS_SIZE}
	round-robin: ${NSD_ROUND_ROBIN}
	refuse-any: ${NSD_REFUSE_ANY}
	zonefiles-check: yes
	zonefiles-write: 0
	# Service clients over TLS (on the TCP sockets), with plain DNS inside
	# the TLS stream. Give the certificate to use and private key.
	# Default is "" (disabled). Requires restart to take effect.
	tls-service-key: "${NSD_TLS_SERVICE_KEY}"
	tls-service-pem: "${NSD_TLS_SERVICE_PEM}"
	tls-service-ocsp: "${NSD_TLS_SERVICE_OCSP}"
	tls-port: 853


dnstap:
	dnstap-enable: ${NSD_DNSTAP_ENABLE}
	dnstap-socket-path: "{NSD_DNSTAP_SOCKET_PATH}"
	dnstap-send-identity: ${NSD_DNSTAP_SEND_IDENTITY}
	dnstap-send-version:  ${NSD_DNSTAP_SEND_VERSION}
	dnstap-identity: "${NSD_DNSTAP_VERSION}"
	dnstap-version: "${NSD_DNSTAP_VERSION}"
	dnstap-log-auth-query-messages: ${NSD_DNSTAP_LOG_AQ_MESSAGE}
	dnstap-log-auth-response-messages: ${NSD_DNSTAP_LOG_AR_MESSAGE}

remote-control:
	control-enable: yes
	control-interface: 127.0.0.1
	control-port: 8952
	server-key-file: "/etc/nsd/nsd_server.key"
	server-cert-file: "/etc/nsd/nsd_server.pem"
	control-key-file: "/etc/nsd/nsd_control.key"
	control-cert-file: "/etc/nsd/nsd_control.pem"

include: "/etc/nsd/config/*.conf"
