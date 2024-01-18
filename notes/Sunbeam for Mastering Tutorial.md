# Sunbeam

## Installation

You will need a single machine whose requirements are:

- physical or virtual machine running Ubuntu 22.04 LTS
- a multi-core amd64 processor with 16+ cores
- a minimum of 32 GiB of free memory
- 180 GiB of SSD storage available on the root disk

We start with installing Openstack and bootstrapping it with default values.

```bash
sudo snap install openstack --channel 2023.1/stable
sunbeam prepare-node-script | bash -x && newgrp snap_daemon
sunbeam cluster bootstrap --accept-defaults
```

Once the control plane has been deployed, which can take around 30 minutes, you can then create a demo project for the remainder of the tutorial to use.

```bash
sunbeam configure --accept-defaults -o ~/sunbeam-user.rc
sunbeam openrc > ~/sunbeam-admin.rc
```

# Setup for SD-Core

## Networking

### Networks

SD-Core CUPS has specific network requirements (diagram here?).  In this next step we will create the virtual networks for the various components to use.  Note that these will be VXLAN overlays, so the MTU size in each VM will be 1450. This will be important later when we deploy the SD-Core software.

```bash
openstack << EOF
network create access
subnet create --dhcp --gateway none --allocation-pool start=10.202.1.0,end=10.202.1.254 --subnet-range 10.202.0.0/16 --network access subnet.10.202.0.0 --host-route destination=10.204.0.0/16,gateway=10.202.0.1

network create core
subnet create --dhcp --gateway none --allocation-pool start=10.203.1.0,end=10.203.1.254 --subnet-range 10.203.0.0/16 --network core subnet.10.203.0.0

network create ran
subnet create --dhcp --gateway none --allocation-pool start=10.204.1.0,end=10.204.1.254 --subnet-range 10.204.0.0/16 --network ran subnet.10.204.0.0 --host-route destination=10.202.0.0/16,gateway=10.204.0.1
EOF
```

### Ports

We are going to assign IP addresses and names to each port for DNS


#### Routers
```bash
openstack << EOF
port create --disable-port-security --fixed-ip ip-address=10.203.0.1 --enable --project demo --network core router.core

port create --disable-port-security --fixed-ip ip-address=10.201.10.254 --enable --project demo --network demo-network core-router.management

port create --disable-port-security --fixed-ip ip-address=10.202.0.1 --enable --project demo --network access router.access
port create --disable-port-security --fixed-ip ip-address=10.204.0.1 --enable --project demo --network ran router.ran

port create --disable-port-security --fixed-ip ip-address=10.201.11.254 --enable --project demo --network management ran-access-router.management
```

#### Service VMs

```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.10 --enable --project demo --network management juju-controller.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.11 --enable --project demo --network management control-plane.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.12 --enable --project demo --network management user-plane.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.13 --enable --project demo --network management gnbsim.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.0.14 --enable --project demo --network management ueransim.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.2.1 --enable --project demo --network management ue-1.mgmt&
openstack port create --disable-port-security --fixed-ip ip-address=10.201.2.2 --enable --project demo --network management ue-2.mgmt
```

#### Ports for UPF

```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.202.0.2 --enable --project demo --network access user-plane.access&
openstack port create --disable-port-security --fixed-ip ip-address=10.203.0.2 --enable --project demo --network core user-plane.core
```

#### Ports for gNBsim

```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.204.0.2 --enable --project demo --network ran gnbsim.ran
```

#### Ports for UERANsim

```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.204.0.3 --enable --project demo --network ran ueransim.ran
```

#### Ports for UE
```bash
openstack port create --disable-port-security --fixed-ip ip-address=10.204.0.101 --enable --project demo --network ran ue-1.ran
openstack port create --disable-port-security --fixed-ip ip-address=10.204.0.102 --enable --project demo --network ran ue-2.ran
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
cp ~/.ssh/id_rsa.pub ~/
openstack keypair create score --public-key ~/id_rsa.pub
rm ~/id_rsa.pub
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

