# Setup

## Ryzen

Have .ssh/authorized keys setup for ubuntu. User also has sudo access

## juju-controller

Export local LXD info to add as a cloud to the SD-Core Controller

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

juju add-model user-plane lxd-cloud
juju add-machine ssh:ubuntu@ryzen.lab --private-key ./id_rsa
```

# Deploy

```bash
juju deploy sdcore-upf \
  --base ubuntu@22.04 \
  --config access-interface-name=vlan.1202 \
  --config core-interface-name=vlan.1203 \
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

