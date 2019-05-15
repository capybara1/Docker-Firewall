FROM alpine:3.9
RUN apk --no-cache add iptables
VOLUME /etc/iptables
ENTRYPOINT exec /sbin/iptables-restore -n < /etc/iptables/state