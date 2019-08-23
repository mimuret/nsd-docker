FROM alpine:3.10 as builder
ARG VERSION
RUN apk --update --no-cache add wget gcc make musl-dev
RUN apk --update --no-cache add libevent-dev openssl-dev protobuf-c fstrm-dev protobuf-c-dev
RUN wget https://nlnetlabs.nl/downloads/nsd/nsd-${VERSION}.tar.gz
RUN tar -zxf nsd-${VERSION}.tar.gz
RUN cd nsd-${VERSION} && ./configure \
--prefix=/nsd \
--with-username=daemon \
--with-configdir=/etc/nsd \
--with-nsd_conf_file=/etc/nsd/nsd.conf \
--with-libfstrm \
--with-protobuf-c \
--with-ssl \
--with-libevent \
--with-dnstap-socket-path=/nsd/run/dnstap.sock \
--enable-dnstap \
--enable-ratelimit-default-is-off \
--enable-checking \
--enable-zone-stats \
--enable-bind8-stats && \
make -j4 && \
make install && \
rm -rf /nsd/share && \
mkdir /nsd/var/run 

FROM alpine:3.10
ARG VERSION
ENV NSD_VERBOSITY 0
ENV NSD_DO_IPV4 "yes"
ENV NSD_DO_IPV6 "no"
ENV NSD_HIDE_VERSION "yes"
ENV NSD_HIDE_IDENTITY "yes"
ENV NSD_IDENTITY ""
ENV NSD_TCP_COUNT 100
ENV NSD_IPV4_EDNS_SIZE 1220
ENV NSD_IPV6_EDNS_SIZE 1220
ENV NSD_ROUND_ROBIN "yes"
ENV NSD_REFUSE_ANY "yes"
ENV NSD_DNSTAP_ENABLE "yes"
ENV NSD_DNSTAP_SOCKET_PATH "/nsd/var/run/dnstap.sock"
ENV NSD_DNSTAP_SEND_IDENTITY "no"
ENV NSD_DNSTAP_SEND_VERSION "no"
ENV NSD_DNSTAP_VERSION ""
ENV NSD_DNSTAP_LOG_AQ_MESSAGE "yes"
ENV NSD_DNSTAP_LOG_AR_MESSAGE "yes"
ENV NSD_TLS_SERVICE_KEY ""
ENV NSD_TLS_SERVICE_PEM ""
ENV NSD_TLS_SERVICE_OCSP ""

COPY entrypoint.sh /
RUN apk --update --no-cache add libevent openssl fstrm protobuf-c gettext && \
chmod 755 /entrypoint.sh && \
ln -s /dev/stdout /var/log/nsd.log
COPY --from=builder --chown=daemon:daemon /nsd /nsd
COPY --chown=daemon:daemon conf /etc/nsd

ENTRYPOINT [ "/entrypoint.sh" ]
CMD ["/nsd/sbin/nsd", "-d"]