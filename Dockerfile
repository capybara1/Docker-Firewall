FROM alpine:3.9
LABEL version="1.0"
RUN apk --no-cache add iptables
VOLUME /etc/iptables
ENTRYPOINT exec /sbin/iptables-restore -n < /etc/iptables/state