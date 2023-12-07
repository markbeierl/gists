# Sunbeam

## Installation

### Xeon

`Sunbeam-preseed.yaml`
```yaml
bootstrap:
  management_cidr: 10.0.0.0/16
addons:
  metallb: 10.0.4.0-10.0.4.10
user:
  run_demo_setup: True
  username: demo
  password: demo
  cidr: 192.168.250.0/24
  nameservers: 10.0.0.2
  security_group_rules: True
  # Local or remote access to VMs
  remote_access_location: remote
external_network:
  cidr: 10.0.0.0/16
  # Start of IP allocation range for external network
  start: 10.0.4.129
  # End of IP allocation range for external network
  end: 10.0.4.254
  # Network type for access to external network
  network_type: flat
  # segmentation_id: 101
  nic: enp8s0
  gateway: 10.0.0.1
# MicroCeph config
microceph_config:
  xeon.lab:
    # Disks to attach to MicroCeph
    osd_devices: /dev/disk/by-id/nvme-nvme.126f-504c3233303732305953423235364730303035-54696d657465632033355454465036504349452d32353647-00000001
```

Install controller and first compute on Xeon

```bash
sudo snap install openstack --channel 2023.1/stable
sunbeam prepare-node-script | bash -x
sunbeam cluster bootstrap --database single --role control --role compute --role storage -p ./sunbeam-preseed.yaml
sunbeam configure -p ./sunbeam-preseed.yaml -o ./sunbeam-user.rc
sunbeam openrc > sunbeam-admin.rc
```

Generate token for Ryzen
```bash
sunbeam cluster add --name ryzen.lab
```

### Ryzen

```bash
sudo snap install openstack --channel 2023.1
sunbeam prepare-node-script | bash -x
```

Get token from Xeon
```bash
sunbeam cluster join --role compute --token
```

## Configure

As admin
```bash
. ~/bin/sunbeam-admin.rc
```

### Zones

```bash
openstack aggregate create xeon --zone xeon
openstack aggregate add host xeon xeon.lab
openstack aggregate create ryzen --zone ryzen
openstack aggregate add host ryzen ryzen.lab
```

### Overcommit

```bash
for HV in $(openstack resource provider list -c uuid -f value) ; do
  openstack resource provider inventory set --amend --resource MEMORY_MB:allocation_ratio=1.0 --resource VCPU:allocation_ratio=16.0 $HV
done
```

### Images

```bash
openstack image create --public --container-format=bare --disk-format=qcow2 ubuntu16.04 --file=/home/mark/Downloads/ubuntu-16.04-server-cloudimg-amd64-disk1.img
openstack image create --public --container-format=bare --disk-format=qcow2 ubuntu18.04 --file=/home/mark/Downloads/ubuntu-18.04-server-cloudimg-amd64.img
openstack image create --public --container-format=bare --disk-format=qcow2 ubuntu20.04 --file=/home/mark/Downloads/ubuntu-20.04-server-cloudimg-amd64.img
```


## Networking for SD-Core
As admin
```bash
. ~/bin/sunbeam-admin.rc
```

### Networks
I didn't add gateways for access, ran or core as that interferes witht the default route.  Each server will assign its own routes anyway for the networks.

```bash
openstack << EOF
network create --share --external --provider-physical-network physnet1 --provider-network-type vlan --provider-segment 1201 management
subnet create --dhcp --gateway 10.201.0.1 --dns-nameserver 10.0.0.2 --allocation-pool start=10.201.1.0,end=10.201.1.254 --subnet-range 10.201.0.0/16 --network management subnet.10.201.0.0

network create --share --external --provider-physical-network physnet1 --provider-network-type vlan --provider-segment 1202 access
subnet create --dhcp --gateway none --allocation-pool start=10.202.1.0,end=10.202.1.254 --subnet-range 10.202.0.0/16 --network access subnet.10.202.0.0 --host-route destination=10.204.0.0/16,gateway=10.202.0.1

network create --share --external --provider-physical-network physnet1 --provider-network-type vlan --provider-segment 1203 core
subnet create --dhcp --gateway none --allocation-pool start=10.203.1.0,end=10.203.1.254 --subnet-range 10.203.0.0/16 --network core subnet.10.203.0.0

network create --share --external --provider-physical-network physnet1 --provider-network-type vlan --provider-segment 1204 ran
subnet create --dhcp --gateway none --allocation-pool start=10.204.1.0,end=10.204.1.254 --subnet-range 10.204.0.0/16 --network ran subnet.10.204.0.0 --host-route destination=10.202.0.0/16,gateway=10.204.0.1
EOF
```

### Ports
```bash
export PROJECT=demo
. ~/bin/sunbeam-admin.rc
```
#### Core Router
```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.203.0.1 --enable --project ${PROJECT} --network core router.core &
openstack port create --disable-port-security --fixed-ip ip-address=10.201.10.254 --enable --project ${PROJECT} --network management core-router.management
```

#### RAN/Access ROUTER

```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.202.0.1 --enable --project ${PROJECT} --network access router.access &
openstack port create --disable-port-security --fixed-ip ip-address=10.204.0.1 --enable --project ${PROJECT} --network ran router.ran &
openstack port create --disable-port-security --fixed-ip ip-address=10.201.11.254 --enable --project ${PROJECT} --network management ran-access-router.management
```

#### Service VMs

```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.10 --enable --project ${PROJECT} --network management juju-controller.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.11 --enable --project ${PROJECT} --network management control-plane.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.12 --enable --project ${PROJECT} --network management user-plane.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.13 --enable --project ${PROJECT} --network management gnbsim.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.14 --enable --project ${PROJECT} --network management ueransim.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.2.1 --enable --project ${PROJECT} --network management ue-1.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.2.2 --enable --project ${PROJECT} --network management ue-2.mgmt
```

#### Ports for UPF

```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.202.0.2 --enable --project ${PROJECT} --network access user-plane.access&
openstack port create --disable-port-security --fixed-ip ip-address=10.203.0.2 --enable --project ${PROJECT} --network core user-plane.core
```

#### Ports for gNBsim

```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.204.0.2 --enable --project ${PROJECT} --network ran gnbsim.ran
```

#### Ports for UERANsim

```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.204.0.3 --enable --project ${PROJECT} --network ran ueransim.ran
```

#### Ports for UE
```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.204.0.101 --enable --project ${PROJECT} --network ran ue-1.ran
openstack port create --disable-port-security --fixed-ip ip-address=10.204.0.102 --enable --project ${PROJECT} --network ran ue-2.ran
```

### Flavours

```bash
openstack << EOF
flavor create 2C-4R-20D-hp    --public --vcpus 2 --ram 4096 --disk 20 --property hw:mem_page_size=1GB

flavor create juju-controller --public --vcpus 2 --ram 8192 --disk 20
flavor create control-plane   --public --vcpus 4 --ram 8192 --disk 120 
flavor create user-plane      --public --vcpus 4 --ram 8192 --disk 20
flavor create gnbsim          --public --vcpus 4 --ram 4092 --disk 20

flavor create ransim          --public --vcpus 4 --ram 4092 --disk 20
flavor create uesim           --public --vcpus 2 --ram 4092 --disk 20
flavor create router          --public --vcpus 1 --ram 2048 --disk 20
EOF
```

## Servers

As user, create key
```bash
. ~/bin/sunbeam-user.rc
export KEY_NAME=mbeierl
openstack keypair create ${KEY_NAME} --public-key ./id_rsa.pub
```

### Core Router
```bash
openstack server create --availability-zone xeon --key-name ${KEY_NAME} --flavor router --image ubuntu --nic port-id=core-router.management --nic port-id=router.core core-router
```
- log in, set up ip forwarding and nat
```bash
ssh ubuntu@core-router.mgmt
cat << EOF | sudo tee /etc/rc.local
#!/bin/bash
iptables -t nat -A POSTROUTING -o ens3 -j MASQUERADE -s 10.203.0.0/16
EOF
sudo chmod +x /etc/rc.local
sudo /etc/rc.local
echo net.ipv4.ip_forward=1 | sudo tee /etc/sysctl.conf
sudo sysctl -w net.ipv4.ip_forward=1
```

### Access/RAN Router

```bash
openstack server create --availability-zone xeon --key-name ${KEY_NAME} --flavor router --image ubuntu --nic port-id=ran-access-router.management --nic port-id=router.access --nic port-id=router.ran ran-access-router
```
- Set up IP forwarding
```bash
ssh ubuntu@ran-access-router.mgmt
echo net.ipv4.ip_forward=1 | sudo tee /etc/sysctl.conf
sudo sysctl -w net.ipv4.ip_forward=1
```

### Service VMs

```bash
openstack server create --availability-zone xeon  --key-name ${KEY_NAME} --flavor juju-controller --image ubuntu --nic port-id=juju-controller.mgmt juju-controller&
openstack server create --availability-zone xeon  --key-name ${KEY_NAME} --flavor control-plane --image ubuntu --nic port-id=control-plane.mgmt control-plane&
openstack server create --availability-zone ryzen --key-name ${KEY_NAME} --flavor user-plane --image ubuntu --nic port-id=user-plane.mgmt --nic port-id=user-plane.access --nic port-id=user-plane.core user-plane&
openstack server create --availability-zone xeon  --key-name ${KEY_NAME} --flavor gnbsim --image ubuntu --nic port-id=gnbsim.mgmt --nic port-id=gnbsim.ran gnbsim&
openstack server create --availability-zone xeon  --key-name ${KEY_NAME} --flavor ransim --image ubuntu --nic port-id=ueransim.mgmt --nic port-id=ueransim.ran ransim&
openstack server create --availability-zone xeon  --key-name ${KEY_NAME} --flavor uesim --image ubuntu --nic port-id=ue-1.mgmt --nic port-id=ue-1.ran ue-1&
openstack server create --availability-zone xeon  --key-name ${KEY_NAME} --flavor uesim --image ubuntu --nic port-id=ue-2.mgmt --nic port-id=ue-2.ran ue-2
```

# Bootstrapping

## Setup
```bash
scp ~/.ssh/id_rsa ubuntu@user-plane.mgmt:.ssh/
scp ~/.ssh/id_rsa ubuntu@control-plane.mgmt:.ssh/
scp ~/.ssh/id_rsa ubuntu@gnbsim.mgmt:.ssh/
scp ~/.ssh/id_rsa ubuntu@juju-controller.mgmt:.ssh/

for VM in control-plane.mgmt user-plane.mgmt juju-controller.mgmt gnbsim.mgmt ; do
  setup-ceph.sh $VM
done
```

