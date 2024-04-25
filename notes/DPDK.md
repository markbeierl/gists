# DPDK

# UPF Charm Bare Metal K8s + SR-IOV

## Ryzen Host

```bash
sudo apt install -y driverctl net-tools
```

## Huge pages

On bare metal host

```bash
sudo sed -i "s/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX='default_hugepagesz=1G hugepages=32'/" /etc/default/grub
sudo update-grub
sudo init 6
```

## Microk8s

```bash
sudo snap install microk8s --channel=1.29/stable --classic
sudo microk8s enable hostpath-storage
sudo microk8s addons repo add community https://github.com/canonical/microk8s-community-addons --reference feat/strict-fix-multus
sudo microk8s enable multus
sudo usermod -a -G microk8s $USER
sudo snap alias microk8s.kubectl kubectl
sudo microk8s.config > user-plane-cluster.yaml
sudo microk8s enable metallb:10.201.0.200/32
```

## VF Configuration

For reference

```bash
08:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)  PF #1
08:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)  PF #2
09:10.0 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.0
09:10.1 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.0
09:10.2 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.1
09:10.3 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.1
09:10.4 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.2
09:10.5 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.2
09:10.6 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.3
09:10.7 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.3
09:11.0 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.4
09:11.1 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.4
09:11.2 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.5
09:11.3 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.5
09:11.4 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.6
09:11.5 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.6

    vf 0     link/ether 96:de:a6:63:27:0a brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 1     link/ether e2:e8:59:1e:b2:7d brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 2     link/ether 26:b9:dd:6d:26:b1 brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 3     link/ether 12:e7:dc:f4:96:4f brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 4     link/ether f6:9a:d5:0d:a5:d8 brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 5     link/ether f2:3d:9a:8b:4e:64 brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 6     link/ether 76:4d:9a:c7:eb:ff brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off

    vf 0     link/ether 36:cd:1f:43:b7:2b brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 1     link/ether 0a:de:5c:ef:4c:dd brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 2     link/ether 2a:8c:69:30:a2:56 brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 3     link/ether ce:89:20:66:e5:b8 brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 4     link/ether 1e:82:5c:79:5c:e6 brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 5     link/ether e2:d3:00:3e:f0:8f brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off
    vf 6     link/ether ee:f3:bd:91:27:28 brd ff:ff:ff:ff:ff:ff, spoof checking off, link-state auto, trust off


```

```bash
cat << EOF | sudo tee /etc/rc.local
#!/bin/bash
driverctl set-override 0000:09:10.0 vfio-pci
driverctl set-override 0000:09:10.1 vfio-pci
driverctl set-override 0000:09:10.2 vfio-pci
driverctl set-override 0000:09:10.3 vfio-pci
driverctl set-override 0000:09:10.4 vfio-pci
driverctl set-override 0000:09:10.5 vfio-pci
driverctl set-override 0000:09:10.6 vfio-pci
driverctl set-override 0000:09:10.7 vfio-pci
driverctl set-override 0000:09:11.0 vfio-pci
driverctl set-override 0000:09:11.1 vfio-pci
driverctl set-override 0000:09:11.2 vfio-pci
driverctl set-override 0000:09:11.3 vfio-pci
driverctl set-override 0000:09:11.4 vfio-pci
driverctl set-override 0000:09:11.5 vfio-pci

ip link set enp8s0f0 vf 0 spoofchk off vlan 1202
ip link set enp8s0f0 vf 1 spoofchk off vlan 1202
ip link set enp8s0f0 vf 2 spoofchk off vlan 1202
ip link set enp8s0f0 vf 3 spoofchk off vlan 1202
ip link set enp8s0f0 vf 4 spoofchk off vlan 1202
ip link set enp8s0f0 vf 5 spoofchk off vlan 1202
ip link set enp8s0f0 vf 6 spoofchk off vlan 1202
ip link set enp8s0f1 vf 0 spoofchk off vlan 1203
ip link set enp8s0f1 vf 1 spoofchk off vlan 1203
ip link set enp8s0f1 vf 2 spoofchk off vlan 1203
ip link set enp8s0f1 vf 3 spoofchk off vlan 1203
ip link set enp8s0f1 vf 4 spoofchk off vlan 1203
ip link set enp8s0f1 vf 5 spoofchk off vlan 1203
ip link set enp8s0f1 vf 6 spoofchk off vlan 1203

EOF
```

```bash
sudo chmod +x /etc/rc.local
sudo /etc/rc.local
sudo driverctl list-devices
ip link show
```

## SR-IOV K8s Setup

Download the ONF CNI script

```bash
sudo mkdir -p /opt/cni/bin
sudo wget -O /opt/cni/bin/vfioveth https://raw.githubusercontent.com/opencord/omec-cni/master/vfioveth
sudo chmod +x /opt/cni/bin/vfioveth
```

Select all the VFs on the first PF for access, and all the VFs on the second PF as core.

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: sriovdp-config
  namespace: kube-system
data:
  config.json: |
    {
     "resourceList": [
        {
          "resourceName": "intel_sriov_vfio_access",
          "selectors": {
            "drivers": ["vfio-pci"],
            "pfNames": ["enp8s0f0"]
          }
        },
        {
          "resourceName": "intel_sriov_vfio_core",
          "selectors": {
            "drivers": ["vfio-pci"],
            "pfNames": ["enp8s0f1"]
          }
        }
      ]
    }
EOF
```

Install the newer daemonset.

```bash
kubectl apply -f https://raw.githubusercontent.com/k8snetworkplumbingwg/sriov-network-device-plugin/v3.6.2/deployments/sriovdp-daemonset.yaml
```

Verify they got loaded
```bash
kubectl get node -o json | jq '.items[].status.allocatable'
```
```json
{
  "cpu": "16",
  "ephemeral-storage": "513888512Ki",
  "hugepages-1Gi": "4Gi",
  "hugepages-2Mi": "2Gi",
  "intel.com/intel_sriov_vfio_access": "7",
  "intel.com/intel_sriov_vfio_core": "7",
  "memory": "59347368Ki",
  "pods": "110"
}
```

Can also check sriovdp logs:

```bash
kubectl logs -n kube-system kube-sriov-device-plugin-amd64-
```
```
I0308 22:37:45.329946       1 manager.go:138] initServers(): selector index 0 will register 7 devices
I0308 22:37:45.329954       1 factory.go:124] device added: [identifier: 0000:09:10.1, vendor: 8086, device: 10ca, driver: vfio-pci]
I0308 22:37:45.329959       1 factory.go:124] device added: [identifier: 0000:09:10.3, vendor: 8086, device: 10ca, driver: vfio-pci]
I0308 22:37:45.329962       1 factory.go:124] device added: [identifier: 0000:09:10.5, vendor: 8086, device: 10ca, driver: vfio-pci]
I0308 22:37:45.329965       1 factory.go:124] device added: [identifier: 0000:09:10.7, vendor: 8086, device: 10ca, driver: vfio-pci]
I0308 22:37:45.329968       1 factory.go:124] device added: [identifier: 0000:09:11.1, vendor: 8086, device: 10ca, driver: vfio-pci]
I0308 22:37:45.329971       1 factory.go:124] device added: [identifier: 0000:09:11.3, vendor: 8086, device: 10ca, driver: vfio-pci]
I0308 22:37:45.329974       1 factory.go:124] device added: [identifier: 0000:09:11.5, vendor: 8086, device: 10ca, driver: vfio-pci]
I0308 22:37:45.329981       1 manager.go:156] New resource server is created for intel_sriov_vfio_core ResourcePool
```

## SD-Core Control Plane Setup

Followed the tutorial using [VMs in OpenStack](https://github.com/markbeierl/gists/blob/main/notes/Sunbeam.md#networking-for-sd-core).

## User Plane With DPDK and Terraform

Build bessd rock with DPDK 22.11 patch:

```bash
cd ~/git/GitHub/canonical/sdcore-upf-bess-rock
gh checkout pr 15
time rockcraft pack

sudo microk8s ctr image import --base-name docker.io/mbeierl/sdcore-upf-bess ~/git/GitHub/canonical/sdcore-upf-bess-rock/sdcore-upf-bess_1.3_amd64.rock
```

Preapre Terraform modules:

```bash
cp ~/main.tf .
cat << EOF >> main.tf
module "sdcore-user-plane" {
  source = "git::https://github.com/canonical/terraform-juju-sdcore-k8s//modules/sdcore-user-plane-k8s"

  model_name   = "user-plane"
  create_model = false

  upf_config = {
    cni-type                     = "vfioveth"
    access-gateway-ip            = "10.202.0.1"
    access-interface-mac-address = "fa:16:3e:c4:65:0a"
    access-ip                    = "10.202.0.10/16"
    core-gateway-ip              = "10.203.0.1"
    core-interface-mac-address   = "fa:16:3e:20:3e:2e"
    core-ip                      = "10.203.0.10/16"
    enable-hw-checksum           = "false"
    external-upf-hostname        = "upf.mgmt"
    gnb-subnet                   = "10.204.0.0/16"
    upf-mode                     = "dpdk"
  }
}

resource "juju_offer" "upf-fiveg-n4" {
  model            = "user-plane"
  application_name = module.sdcore-user-plane.upf_app_name
  endpoint         = module.sdcore-user-plane.fiveg_n4_endpoint
}

EOF
```

But I cannot use TF at the moment because I don't know how to specify a image resource (my locally built bess)

So, back to the bundle it is:
```bash
cat << EOF > ~/upf-overlay.yaml
applications:
  upf:
    resources:
      bessd-image: mbeierl/sdcore-upf-bess:1.3
    options:
      access-gateway-ip: 10.202.0.1
      access-interface-mac-address: fa:16:3e:c4:65:0a
      access-ip: 10.202.0.10/24
      core-gateway-ip: 10.203.0.1
      core-interface-mac-address: fa:16:3e:20:3e:2e
      core-ip: 10.203.0.10/24
      external-upf-hostname: upf.mgmt
      gnb-subnet: 10.204.0.0/16
      cni-type: vfioveth
      enable-hw-checksum: false
      upf-mode: dpdk
EOF
```

```bash
juju add-model user-plane user-plane-cluster
juju deploy sdcore-user-plane-k8s --trust --channel=1.3/edge --overlay ~/upf-overlay.yaml
```

And it is working. Or at least bessd is configured. Let's try putting on my home subnet:

```bash
juju config upf \
  access-gateway-ip=10.0.0.1 \
  access-ip=10.0.50.1/16
```

It failed as that collided with the default route for the container and all manner of network failures were reported.

I need to figure out VLAN tags for the CNI definition. Builing locally on juju controller

```bash
cd ~/git/GitHub/canonical/sdcore-upf-k8s-operator/
time charmcraft pack
juju deploy ./sdcore-upf-k8s_ubuntu-22.04-amd64.charm upf \
 --resource bessd-image=mbeierl/sdcore-upf-bess:1.3 \
 --resource pfcp-agent-image=ghcr.io/canonical/sdcore-upf-pfcpiface:1.3 \
 --config access-gateway-ip=10.202.0.1 \
 --config access-interface-mac-address=fa:16:3e:c4:65:0a \
 --config access-ip=10.202.0.10/16 \
 --config cni-type=vfioveth \
 --config core-gateway-ip=10.203.0.1 \
 --config core-interface-mac-address=fa:16:3e:20:3e:2e \
 --config core-ip=10.203.0.10/16 \
 --config enable-hw-checksum=false \
 --config external-upf-hostname=upf.mgmt \
 --config gnb-subnet=10.204.0.0/16 \
 --config upf-mode=dpdk
```

-----------------------------------------------------------------------------
# DPDK only in a User Plane VM

Launched my regular User plane VM, installed classic microk8s on it.

This is what lshw looks like before `driverctl set-override`:

```bash
ubuntu@user-plane:~$ sudo lshw -c network -businfo
Bus info          Device      Class          Description
========================================================
pci@0000:00:03.0              network        Virtio network device
virtio@0          ens3        network        Ethernet interface
pci@0000:00:04.0              network        Virtio network device
virtio@1          ens4        network        Ethernet interface
pci@0000:00:05.0              network        Virtio network device
virtio@2          ens5        network        Ethernet interface
```

```bash
echo "vfio-pci" | sudo tee /etc/modules-load.d/vfio-pci.conf
echo "options vfio enable_unsafe_noiommu_mode=1" | sudo tee /etc/modprobe.d/vfio-noiommu.conf

sudo modprobe vfio-pci
sudo modprobe vfio enable_unsafe_noiommu_mode=1
cat /sys/module/vfio/parameters/enable_unsafe_noiommu_mode
echo 1 | sudo tee /sys/module/vfio/parameters/enable_unsafe_noiommu_mode

sudo apt install driverctl

sudo driverctl set-override 0000:00:04.0 vfio-pci
sudo driverctl set-override 0000:00:05.0 vfio-pci
```

Definitely need the newer one:

```bash
kubectl apply -f https://raw.githubusercontent.com/k8snetworkplumbingwg/sriov-network-device-plugin/v3.6.2/deployments/sriovdp-daemonset.yaml
```

```bash
sudo mkdir -p /opt/cni/bin
sudo wget -O /opt/cni/bin/vfioveth https://raw.githubusercontent.com/opencord/omec-cni/master/vfioveth
sudo chmod +x /opt/cni/bin/vfioveth
```

The sriovdp configmap.  Check the ip link output to see which device is core and which is access.

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ConfigMap
metadata:
  name: sriovdp-config
  namespace: kube-system
data:
  config.json: |
    {
     "resourceList": [
        {
          "resourceName": "intel_sriov_vfio_access",
          "selectors": {
            "pciAddresses": ["0000:00:04.0"]
          }
        },
        {
          "resourceName": "intel_sriov_vfio_core",
          "selectors": {
            "pciAddresses": ["0000:00:05.0"]
          }
        }
      ]
    }
EOF
```

```bash
kubectl get node  -o json | jq '.items[].status.allocatable'
```

Trying the new DPDK from Ghislain:

```bash
cd ~/git/GitHub/canonical/sdcore-upf-bess-rock
gh checkout pr 15
time rockcraft pack
```

On the user-plane vm, load the rock into microk8s:

```bash
sudo microk8s ctr image import --base-name docker.io/mbeierl/sdcore-upf-bess ~/git/GitHub/canonical/sdcore-upf-bess-rock/sdcore-upf-bess_1.3.1_amd64.rock
```

Deployment on the juju-controller:

```bash
cat << EOF > upf-dpdk.yaml
applications:
  upf:
    resources:
      bessd-image: mbeierl/sdcore-upf-bess:1.3
    options:
      access-gateway-ip: 10.202.0.1
      access-interface-mac-address: fa:16:3e:8b:61:89
      access-ip: 10.202.0.10/16
      core-gateway-ip: 10.203.0.1
      core-interface-mac-address: fa:16:3e:7c:7a:cc
      core-ip: 10.203.0.10/16
      external-upf-hostname: upf.mgmt
      gnb-subnet: 10.204.0.0/16
      cni-type: vfioveth
      enable-hw-checksum: false
      upf-mode: dpdk
EOF
```

```bash
juju deploy
```

On the gnbsim VM, run UERANSIM and use:

```bash
sudo ip route add 10.203.0.0/16 dev uesimtun0
ping -I uesimtun0 service-1.core -c 6000 -i .1 -s 36 | grep rtt
```


# Macvlan

```bash
juju deploy ./sdcore-upf-k8s_ubuntu-22.04-amd64.charm upf \
 --resource bessd-image=ghcr.io/canonical/sdcore-upf-bess:1.3 \
 --resource pfcp-agent-image=ghcr.io/canonical/sdcore-upf-pfcpiface:1.3 \
 --config access-gateway-ip=10.202.0.1 \
 --config access-interface=access \
 --config access-ip=10.202.0.10/16 \
 --config cni-type=macvlan \
 --config core-gateway-ip=10.203.0.1 \
 --config core-interface=core \
 --config core-ip=10.203.0.10/16 \
 --config external-upf-hostname=upf.mgmt \
 --config gnb-subnet=10.204.0.0/16
```

