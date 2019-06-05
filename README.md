# Firewall

[![](https://images.microbadger.com/badges/version/capybara1/firewall.svg)](https://microbadger.com/images/capybara1/firewall "Get your own version badge on microbadger.com")
[![](https://images.microbadger.com/badges/license/capybara1/firewall.svg)](https://microbadger.com/images/capybara1/firewall "Get your own license badge on microbadger.com")
[![](https://images.microbadger.com/badges/image/capybara1/firewall.svg)](https://microbadger.com/images/capybara1/firewall "Get your own image badge on microbadger.com")

## Motivation

Primarily a iptables based firewall script, packaged with the required binaries
for environments where `iptables-restore` is not present.

## Inspirations

Articles that inspired this solution

- [Docker meet firewall - finally an answer](https://unrouted.io/2017/08/15/docker-firewall/)
- [Set iptables rules at startup](https://github.com/rancher/os/issues/446)

## Usage

### Command Line

```bash
docker run \
--rm \
--cap-add=NET_ADMIN \
--cap-add=NET_RAW \
--net=host \
-v /etc/iptables/state:/etc/iptables/state:ro \
capybara1/firewall:latest
```

### Cloud-Init (RancherOS)

```yaml
write_files:
- path: /etc/iptables/state
  permissions: "0400"
  owner: "root:root"
  content: |
    #insert output of iptables-save here
rancher:
  services:
    firewall:
      image: capybara1/firewall:latest
      net: host
      cap_add:
      - NET_ADMIN
      - NET_RAW
      volumes_from:
      - user-volumes
      volumes:
      - /etc/iptables/state:/etc/iptables/state:ro
      labels:
        io.rancher.os.after: wait-for-network, cloud-init
        io.rancher.os.scope: system
        io.rancher.os.detach: "false"
        io.rancher.os.remove: "true"
```
