# DPDK

## Huge pages

On bare metal host

```bash
sudo sed -i "s/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX='default_hugepagesz=1G hugepages=32'/" /etc/default/grub
sudo update-grub
sudo init 6
```

## Microk8s

```bash
sudo snap install microk8s --channel=1.27/stable --classic
sudo microk8s enable hostpath-storage
sudo microk8s enable metallb:10.201.0.201-10.201.0.201 &
sudo microk8s addons repo add community \
    https://github.com/canonical/microk8s-community-addons \
    --reference feat/strict-fix-multus
sudo microk8s enable multus

sudo snap install juju --channel=3.1/stable

sudo microk8s.config > dpdk-cluster.yaml
export KUBECONFIG=dpdk-cluster.yaml
juju add-k8s dpdk-cluster
juju bootstrap dpdk-cluster --config controller-service-type=loadbalancer dpdk
juju add-model dpdk
```

## For LXD VM

For deploying UPF to a VM that will use LXD/Multipass (Mastering Tutorial), need to prepare with noiommu

```console
sudo lshw -c network -businfo

Bus info          Device      Class          Description
========================================================
pci@0000:05:00.0              network        Virtio network device
virtio@10         enp5s0      network        Ethernet interface
pci@0000:06:00.0              network        Virtio network device
virtio@11         enp6s0      network        Ethernet interface
pci@0000:07:00.0              network        Virtio network device
pci@0000:08:00.0              network        Virtio network device
```

Unbind the existing driver, set up vfio-pci

```bash
echo "vfio-pci" | sudo tee /etc/modules-load.d/vfio-pci.conf
sudo modprobe vfio-pci
modprobe vfio enable_unsafe_noiommu_mode=1

sudo apt install driverctl

This part appears to be need to be done on every reboot

echo -n "0000:00:07.0" | sudo tee /sys/bus/pci/drivers/virtio-pci/unbind
echo -n "0000:00:08.0" | sudo tee /sys/bus/pci/drivers/virtio-pci/unbind

echo 1 | sudo tee  /sys/module/vfio/parameters/enable_unsafe_noiommu_mode

sudo driverctl set-override 0000:00:07.0 vfio-pci
sudo driverctl set-override 0000:00:08.0 vfio-pci
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
            "drivers": ["vfio-pci"],
            "pciAddresses": ["0000:08:00.0"]
          }
        },
        {
          "resourceName": "intel_sriov_vfio_core",
          "selectors": {
            "drivers": ["vfio-pci"],
            "pciAddresses": ["0000:07:00.0"]
          }
        }
      ]
    }
EOF
```



```bash
kubectl apply -f https://raw.githubusercontent.com/k8snetworkplumbingwg/sriov-network-device-plugin/v3.3/deployments/k8s-v1.16/sriovdp-daemonset.yaml
```

kubectl get node  -o json | jq '.items[].status.allocatable'


## Deploy the UPF

```bash
juju add-model user-plane user-plane-cluster
```


```bash
cat << EOF > upf-overlay.yaml
applications:
  upf:
    options:
      upf-mode: dpdk
      access-ip: 10.202.0.10/24
      access-gateway-ip: 10.202.0.1
      core-ip: 10.203.0.10/24
      core-gateway-ip: 10.203.0.1
      access-interface-mac-address: fa:16:3e:f0:97:49
      core-interface-mac-address: fa:16:3e:d1:6a:34
      enable-hugepages: True
EOF
```

### Bessd Rock build

```bash
cd ~/git/GitHub/canonical/sdcore-upf-bess-rock/
time rockcraft pack
```
On the UPF node (if running on Xeon)

```bash
sudo microk8s ctr image import --base-name docker.io/mbeierl/sdcore-upf-bess ~/git/GitHub/canonical/sdcore-upf-bess-rock/sdcore-upf-bess_1.3_amd64.rock
```

Charm deploy - with virtual lans, hardware checksum must be turned off

```bash
juju deploy ./sdcore-upf-k8s_ubuntu-22.04-amd64.charm upf \
 --resource bessd-image=mbeierl/sdcore-upf-bess:1.3 \
 --resource pfcp-agent-image=ghcr.io/canonical/sdcore-upf-pfcpiface:1.3 \
 --config access-ip=10.202.0.10/24  \
 --config access-gateway-ip=10.202.0.1  \
 --config access-interface-mac-address=4a:32:4e:6a:55:ea  \
 --config core-ip=10.203.0.10/24  \
 --config core-gateway-ip=10.203.0.1  \
 --config core-interface-mac-address=12:6b:c6:76:de:81  \
 --config gnb-subnet=10.204.0.0/24  \
 --config upf-mode=dpdk  \
 --config enable-hugepages=True  \
 --config enable-hw-checksum=False
```

In UPF model
```bash
juju offer user-plane.upf:fiveg_n4
```

```bash
juju switch control-plane
juju remove-saas upf
juju consume user-plane.upf
juju integrate upf:fiveg_n4 nms:fiveg_n4
```

### Testing without MAC address

With MAC:

vfioveth.log:
```
{"capabilities":{"mac":true},"cniVersion":"0.3.1","deviceID":"0000:07:00.0","ipam":{"type":"static"},"name":"core-net","pciBusID":"0000:07:00.0","runtimeConfig":{"mac":"12:6b:c6:76:de:81"},"type":"vfioveth"}
```

Without MAC:

no device id. Something in K8s is filtering it out?
```
{"capabilities":{"mac":true},"cniVersion":"0.3.1","ipam":{"type":"static"},"name":"access-net","type":"vfioveth"}
```

## UPF Charm Bare Metal K8s + SR-IOV

# Ryzen

sudo apt install -y driverctl net-tools


## Microk8s

```bash
sudo snap install microk8s --channel=1.27/stable --classic
sudo microk8s enable hostpath-storage
sudo microk8s addons repo add community https://github.com/canonical/microk8s-community-addons --reference feat/strict-fix-multus
sudo microk8s enable multus
sudo usermod -a -G microk8s $USER
sudo snap alias microk8s.kubectl kubectl
sudo microk8s.config > upf-cluster.yaml
```

## Juju

```bash
mkdir -p .local/share/juju
sudo snap install juju --channel=3.1/stable
export KUBECONFIG=upf-cluster.yaml
juju add-k8s upf-cluster
juju bootstrap upf-cluster
juju add-model user-plane
```

## VF Configuration

```bash
08:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)  Physical #1
08:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)  Physical #2
09:10.0 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.1
09:10.1 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.1
09:10.2 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.2
09:10.3 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.2
09:10.4 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.3
09:10.5 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.3
09:10.6 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.4
09:10.7 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.4
09:11.0 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.5
09:11.1 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.5
09:11.2 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.6
09:11.3 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.6
09:11.4 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.7
09:11.5 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.7
```

```bash
sudo driverctl set-override 0000:09:10.0 vfio-pci
sudo driverctl set-override 0000:09:10.1 vfio-pci
sudo driverctl set-override 0000:09:10.2 vfio-pci
sudo driverctl set-override 0000:09:10.3 vfio-pci
sudo driverctl set-override 0000:09:10.4 vfio-pci
sudo driverctl set-override 0000:09:10.5 vfio-pci
sudo driverctl set-override 0000:09:10.6 vfio-pci

sudo driverctl set-override 0000:09:10.7 vfio-pci
sudo driverctl set-override 0000:09:11.0 vfio-pci
sudo driverctl set-override 0000:09:11.1 vfio-pci
sudo driverctl set-override 0000:09:11.2 vfio-pci
sudo driverctl set-override 0000:09:11.3 vfio-pci
sudo driverctl set-override 0000:09:11.4 vfio-pci
sudo driverctl set-override 0000:09:11.5 vfio-pci
```

```bash
kubectl apply -f https://raw.githubusercontent.com/k8snetworkplumbingwg/sriov-network-device-plugin/v3.6.2/deployments/sriovdp-daemonset.yaml
sudo mkdir -p /opt/cni/bin
sudo wget -O /opt/cni/bin/vfioveth https://raw.githubusercontent.com/opencord/omec-cni/master/vfioveth
sudo chmod +x /opt/cni/bin/vfioveth
```

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

On the UPF node (if running on Xeon)
```bash
sudo microk8s ctr image import --base-name docker.io/mbeierl/sdcore-upf-bess ./sdcore-upf-bess_1.3_amd64.rock
```

Deploy locally built charm
```bash
juju deploy sdcore-upf-k8s upf --channel=1.3/edge \
 --config access-ip=10.0.10.10/24 \
 --config access-gateway-ip=10.0.10.1 \
 --config access-interface-mac-address=be:ed:46:1a:8f:a3 \
 --config core-ip=10.0.11.10/24 \
 --config core-gateway-ip=10.0.11.1 \
 --config core-interface-mac-address=3e:88:b3:2d:11:ff \
 --config gnb-subnet=10.204.0.0/24 \
 --config upf-mode=dpdk \
 --config enable-hugepages=True \
 --config enable-hw-checksum=False
```


# Ryzen - bare metal experimentation

Adding dpdk to router for testing

```
juju deploy ./sdcore-router-k8s_ubuntu-22.04-amd64.charm router --trust --channel=1.3/beta --resource router-image=ghcr.io/canonical/ubuntu-router:0.1 --config access-interface=access --config access-gateway-ip=10.0.11.10/24
```


Without VLAN:

Thu Jan 11 09:14:49 PM UTC 2024
+ CNI_CONF='{"capabilities":{"mac":true},"cniVersion":"0.3.1","deviceID":"0000:09:11.5","ipam":{"type":"static"},"name":"core-net","pciBusID":"0000:09:11.5","runtimeConfig":{"mac":"e2:9b:66:f4:6b:6f"},"type":"vfioveth"}'
+ ip netns exec 1bf03ccdf5a80353758d32f6def8c83862e13f1bd6e0cd80dd58d7032afa0016 ip link add core type veth peer name core-vdev
+ ip netns exec 1bf03ccdf5a80353758d32f6def8c83862e13f1bd6e0cd80dd58d7032afa0016 ip link set core addr e2:9b:66:f4:6b:6f up alias 0000:09:11.5
+ ip netns exec 1bf03ccdf5a80353758d32f6def8c83862e13f1bd6e0cd80dd58d7032afa0016 ip link set core-vdev up
+ ip netns exec 1bf03ccdf5a80353758d32f6def8c83862e13f1bd6e0cd80dd58d7032afa0016 ip addr add 10.203.0.10/24 dev core
++ echo '{"capabilities":{"mac":true},"cniVersion":"0.3.1","deviceID":"0000:09:11.5","ipam":{"type":"static"},"name":"core-net","pciBusID":"0000:09:11.5","runtimeConfig":{"mac":"e2:9b:66:f4:6b:6f"},"type":"vfioveth"}'
++ jq -r .deviceID
+ vfpci=0000:09:11.5
++ find /sys/devices/pci0000:00 -name 0000:09:11.5
++ grep -v iommu
+ local vfdir=/sys/devices/pci0000:00/0000:00:03.1/0000:09:11.5
++ readlink /sys/devices/pci0000:00/0000:00:03.1/0000:09:11.5/physfn
++ awk '{print substr($1,4)}'
+ local pf=0000:08:00.1
++ find /sys/devices/pci0000:00 -name 0000:08:00.1
++ grep -v iommu
+ local pfdir=/sys/devices/pci0000:00/0000:00:03.1/0000:08:00.1
++ ls /sys/devices/pci0000:00/0000:00:03.1/0000:08:00.1/net/
++ head -1
+ local pfName=enp8s0f1
++ ls -l /sys/devices/pci0000:00/0000:00:03.1/0000:08:00.1
++ awk -v vf=0000:09:11.5 'substr($11,4)==vf {print substr($9,7)}'
+ local idx=6
+ ls -l /sys/devices/pci0000:00/0000:00:03.1/0000:08:00.1
+ awk -v vf=0000:09:11.5 'substr($11,4)==vf {print substr($9,7)}'
6
++ echo '{"capabilities":{"mac":true},"cniVersion":"0.3.1","deviceID":"0000:09:11.5","ipam":{"type":"static"},"name":"core-net","pciBusID":"0000:09:11.5","runtimeConfig":{"mac":"e2:9b:66:f4:6b:6f"},"type":"vfioveth"}'
++ jq -r '.vlan // empty'
+ vlan=


With VLAN=

Thu Jan 11 09:27:57 PM UTC 2024
+ CNI_CONF='{"capabilities":{"mac":true},"cniVersion":"0.3.1","ipam":{"type":"static"},"name":"access-net","type":"vfioveth"}'


curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 \
--header 'Content-Type: text/plain' \
--data '{
    "UeId":"208930100007487",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'

curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows \
--header 'Content-Type: application/json' \
--data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.0.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1348,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 2000000,
            "dnn-mbr-downlink": 2000000,
            "bitrate-unit": "bps",
            "traffic-class": {
                "name": "platinum",
                "arp": 6,
                "pdb": 300,
                "pelr": 6,
                "qci": 8
            }
        }
    }
}'

curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default \
--header 'Content-Type: application/json' \
--data '{
  "slice-id": {
    "sst": "1",
    "sd": "010203"
  },
  "site-device-group": [
    "cows"
  ],
  "site-info": {
    "site-name": "demo",
    "plmn": {
      "mcc": "208",
      "mnc": "93"
    },
    "gNodeBs": [
      {
        "name": "demo-gnb1",
        "tac": 1
      }
    ],
    "upf": {
      "upf-name": "upf.mgmt",
      "upf-port": "8805"
    }
  }
}'


juju deploy ./sdcore-upf-k8s_ubuntu-22.04-amd64.charm upf \
 --resource bessd-image=ghcr.io/canonical/sdcore-upf-bess:1.3 \
 --resource pfcp-agent-image=ghcr.io/canonical/sdcore-upf-pfcpiface:1.3 \
 --config access-gateway-ip=10.202.0.1 \
 --config access-interface=access \
 --config access-ip=10.202.0.10/24 \
 --config core-gateway-ip=10.203.0.1 \
 --config core-interface=core \
 --config core-ip=10.203.0.10/24 \
 --config gnb-subnet=10.204.0.0/24 \
 --config external-upf-hostname=upf.mgmt



juju deploy ./sdcore-upf-k8s_ubuntu-22.04-amd64.charm upf \
 --resource bessd-image=mbeierl/sdcore-upf-bess:1.3 \
 --resource pfcp-agent-image=ghcr.io/canonical/sdcore-upf-pfcpiface:1.3 \
 --config access-gateway-ip=10.202.0.1 \
 --config access-interface=access \
 --config access-ip=10.202.0.10/24 \
 --config core-gateway-ip=10.203.0.1 \
 --config core-interface=core \
 --config core-ip=10.203.0.10/24 \
 --config gnb-subnet=10.204.0.0/24 \
 --config external-upf-hostname=upf.mgmt



## Juju SR-IOV Plugin

juju deploy sriov-cni
juju deploy sriov-network-device-plugin

```bash
juju config sriov-network-device-plugin resource-list='
[
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
]'
```
Results in
```
panic: runtime error: invalid memory address or nil pointer dereference
[signal SIGSEGV: segmentation violation code=0x1 addr=0x0 pc=0x11eed64]
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
sudo modprobe vfio-pci
sudo modprobe vfio enable_unsafe_noiommu_mode=1
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

```bash
cat << EOF > upf-dpdk.yaml
applications:
  upf:
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
