# Setup

## Ryzen

Have .ssh/authorized keys setup for ubuntu. User also has sudo access

## juju-controller

Export local LXD info to add as a cloud to the SD-Core Controller

```bash
sudo snap install lxd
cat << EOF | lxd init --preseed
config:
  core.https_address: '[::]:8443'
networks:
- config:
    ipv4.address: auto
    ipv6.address: none
  description: ""
  name: lxdbr0
  type: ""
  project: default
storage_pools:
- config:
    size: 5GiB
  description: ""
  name: default
  driver: zfs
profiles:
- config: {}
  description: ""
  devices:
    eth0:
      name: eth0
      network: lxdbr0
      type: nic
    root:
      path: /
      pool: default
      type: disk
  name: default
projects: []
cluster: null
EOF
```

```bash
CONTROLLER_NAME=sdcore
LXDENDPOINT=10.201.0.104
LXD_CLOUD=~/lxd-cloud.yaml
LXD_CREDENTIALS=~/lxd-credentials.yaml
cat << EOF > $LXD_CLOUD
clouds:
  lxd-cloud:
    type: lxd
    auth-types: [certificate]
    endpoint: "https://$LXDENDPOINT:8443"
    config:
      ssl-hostname-verification: false
EOF
openssl req -nodes -new -x509 -keyout ~/client.key -out ~/client.crt -days 365 -subj "/C=CA/ST=ON/L=Cambridge/O=Canonical/OU=Telco/CN=juju-controller.mgmt"
cp /var/snap/lxd/common/lxd/server.crt server.crt
cat << EOF > $LXD_CREDENTIALS
credentials:
  lxd-cloud:
    lxd-cloud:
      auth-type: certificate
      server-cert: ~/server.crt
      client-cert: ~/client.crt
      client-key: ~/client.key
EOF
lxc config trust add local: ~/client.crt

juju add-cloud -c $CONTROLLER_NAME lxd-cloud $LXD_CLOUD --force
juju add-credential -c $CONTROLLER_NAME lxd-cloud -f $LXD_CREDENTIALS

juju add-model user-machine lxd-cloud
juju add-machine ssh:ubuntu@ryzen.lab --private-key ./id_rsa
```

# Deploy

```bash
juju deploy sdcore-upf \
  --base ubuntu@22.04 \
  --channel=1.3/edge \
  --config access-interface-name=v1202 \
  --config core-interface-name=v1203 \
  --config gnb-subnet=10.204.0.0/16 \
  --to 0
```

```bash
juju deploy ./sdcore-upf_ubuntu-22.04-amd64.charm \
  --config access-interface-name=vlan.1202 \
  --config core-interface-name=vlan.1203 \
  --config gnb-subnet=10.204.0.0/16 \
  --to 0
```

juju add-machine ssh:ubuntu@ryzen.lab --private-key ~/./id_rsa
juju deploy ./sdcore-upf_ubuntu-22.04-amd64.charm \
  --config access-ip=10.202.0.10/24 \
  --config access-gateway-ip=10.202.0.1 \
  --config access-interface-name=v1202 \
  --config core-ip=10.203.0.10/24 \
  --config core-gateway-ip=10.203.0.1 \
  --config core-interface-name=v1203 \
  --config gnb-subnet=10.204.0.0/16 \
  --to 3

Cleanup on target host:
```
sudo /sbin/remove-juju-services
sudo snap remove sdcore-upf
```

# Snapcraft fun

## Building the Snap

Multipass could neither mount my cephfs directory, nor provide a large VM for compilation. So I tried LXD, and much better - the build environment uses all 12 CPUs

```bash
export SNAPCRAFT_BUILD_ENVIRONMENT=lxd
snapcraft
```

## Examining the primed Snap
```bash
snapcraft prime --shell-after
```

From there, I see

- `/root/prime`
- `/root/stage`


