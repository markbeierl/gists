# DPDK

## Huge pages

```bash
sudo sed -i "s/GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX='default_hugepagesz=1G hugepages=32'/" /etc/default/grub
sudo update-grub
sudo init 6
```

## Microk8s

```
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



## Remove Config

Log into user plane and possibly remove ens4 and ens5 from netplan

```
echo "vfio-pci" | sudo tee /etc/modules-load.d/vfio-pci.conf
sudo modprobe vfio-pci
modprobe vfio enable_unsafe_noiommu_mode=1

sudo apt install driverctl

echo -n "0000:00:04.0" | sudo tee /sys/bus/pci/drivers/virtio-pci/unbind
echo -n "0000:00:05.0" | sudo tee /sys/bus/pci/drivers/virtio-pci/unbind

## This needs to be done on every reboot?

echo 1 | sudo tee  /sys/module/vfio/parameters/enable_unsafe_noiommu_mode

sudo driverctl set-override 0000:00:04.0 vfio-pci
sudo driverctl set-override 0000:00:05.0 vfio-pci

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
kubectl apply -f https://raw.githubusercontent.com/k8snetworkplumbingwg/sriov-network-device-plugin/v3.3/deployments/k8s-v1.16/sriovdp-daemonset.yaml
```

kubectl get node  -o json | jq '.items[].status.allocatable'


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

https://fast.dpdk.org/rel/dpdk-23.11.tar.xz

```
cd ~/git/GitHub/canonical/sdcore-upf-bess-rock/
time rockcraft pack
sudo microk8s ctr image import --base-name docker.io/mbeierl/sdcore-upf-bess ~/git/GitHub/canonical/sdcore-upf-bess-rock/sdcore-upf-bess_1.3_amd64.rock
```

## UPF Charm

```bash
juju deploy --trust ./sdcore-upf-k8s_ubuntu-22.04-amd64.charm upf \
 --resource bessd-image=ghcr.io/canonical/sdcore-upf-bess:1.3 \
 --resource pfcp-agent-image=ghcr.io/canonical/sdcore-upf-pfcpiface:1.3 \
 --config access-ip=10.202.0.10/24 \
 --config access-gateway-ip=10.202.0.1 \
 --config access-interface=access \
 --config core-ip=10.203.0.10/24 \
 --config core-gateway-ip=10.203.0.1 \
 --config core-interface=core \
 --config gnb-subnet=10.204.0.0/24
 ```

```
cd ~/git/GitHub/canonical/sdcore-upf-operator/
time charmcraft pack
juju deploy --trust ./sdcore-upf_ubuntu-22.04-amd64.charm \
 --resource bessd-image=ghcr.io/canonical/sdcore-upf-bess:1.3 \
 --resource pfcp-agent-image=ghcr.io/canonical/sdcore-upf-pfcpiface:1.3 \
 --config access-ip=10.202.0.10/24 \
 --config access-gateway-ip=10.202.0.1 \
 --config core-ip=10.203.0.10/24 \
 --config core-gateway-ip=10.203.0.1 \
 --config gnb-subnet=10.204.0.0/24 \
 --config upf-mode=dpdk \
 --config enable-hugepages=True \
 --config access-interface-mac-address=FA:16:3E:1A:CD:B6 \
 --config core-interface-mac-address=FA:16:3E:4F:F5:78
```

kubectl get network-attachment-definition -A
kubectl describe network-attachment-definition -n dpdk access-net

Partner Cloud
```
juju deploy --trust ./sdcore-upf_ubuntu-22.04-amd64.charm \
 --resource bessd-image=ghcr.io/canonical/sdcore-upf-bess:1.3 \
 --resource pfcp-agent-image=ghcr.io/canonical/sdcore-upf-pfcpiface:1.3 \
 --config access-ip=10.11.4.10/24 \
 --config access-gateway-ip=10.11.4.1 \
 --config core-ip=10.11.5.10/24 \
 --config core-gateway-ip=10.11.5.1 \
 --config gnb-subnet=10.11.6.0/24 \
 --config upf-mode=dpdk \
 --config enable-hugepages=True \
 --config access-interface-mac-address=02:5c:62:fc:dc:cc \
 --config core-interface-mac-address=0e:96:35:33:fe:2f
```

Openstack on PC7:

Netplan:
/etc/netplan/60-vlan-config.yaml
network:
  ethernets:
    enp129s0f0np0:
      virtual-function-count: 8
    enp129s0f0v0:
      link: enp129s0f0np0
      dhcp4: false
      dhcp6: false
  vlans:
    vlan.2809:
      id: 2809
      link: enp129s0f0v0
      addresses: [194.168.254.254/24]

sudo snap install openstack --channel 2023.1/stable
sunbeam prepare-node-script | bash -x
sunbeam cluster bootstrap --database single --role control --role compute -p ./sunbeam-preseed.yaml
sunbeam configure -p ./sunbeam-preseed.yaml -o ./sunbeam-user.rc
sunbeam openrc > sunbeam-admin.rc

cat << EOF > sunbeam-preseed.yaml
bootstrap:
  management_cidr: 194.168.254.0/24
addons:
  metallb: 194.168.254.240-194.168.254.250
user:
  run_demo_setup: True
  username: demo
  password: demo
  cidr: 192.168.250.0/24
  nameservers: 194.168.254.254
  security_group_rules: True
  # Local or remote access to VMs
  remote_access_location: remote
external_network:
  cidr: 194.168.254.0/24
  start: 10.11.6.200/24
  end: 10.11.6.239/24
  network_type: flat
  nic: enp129s0f1np1
  gateway: 194.168.254.1
EOF
################################################################################

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

```

```bash
08:00.0 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)  Physical #1
08:00.1 Ethernet controller: Intel Corporation 82576 Gigabit Network Connection (rev 01)  Physical #2
09:10.0 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.1
09:10.1 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.2
09:10.2 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.3
09:10.3 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.4
09:10.4 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.5
09:10.5 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.6
09:10.6 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #1.7
09:10.7 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.1
09:11.0 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.2
09:11.1 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.3
09:11.2 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.4
09:11.3 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.5
09:11.4 Ethernet controller: Intel Corporation 82576 Virtual Function (rev 01)            VF #2.6
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

```
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

            "pciAddresses": [
              "0000:09:10.3"
            ]
            "pciAddresses": [
              "0000:09:11.3"
            ]

juju add-model user-plane user-plane-cluster

juju deploy ./sdcore-upf-k8s_ubuntu-22.04-amd64.charm upf \
 --resource bessd-image=mbeierl/sdcore-upf-bess:1.3 \
 --resource pfcp-agent-image=ghcr.io/canonical/sdcore-upf-pfcpiface:1.3 \
 --config access-ip=10.202.0.10/24 \
 --config access-gateway-ip=10.202.0.1 \
 --config access-interface-mac-address=4a:32:4e:6a:55:ea \
 --config core-ip=10.203.0.10/24 \
 --config core-gateway-ip=10.203.0.1 \
 --config core-interface-mac-address=12:6b:c6:76:de:81 \
 --config gnb-subnet=10.204.0.0/24 \
 --config upf-mode=dpdk \
 --config enable-hugepages=True \
 --config enable-hw-checksum=True

      access-gateway-ip: 10.202.0.1
      access-interface: access
      access-ip: 10.202.0.10/24
      core-gateway-ip: 10.203.0.1
      core-interface: core
      core-ip: 10.203.0.10/24
      gnb-subnet: 10.204.0.0/24
      external-upf-hostname: upf.mgmt



2024-01-10T14:16:35.285Z [bessd] I0110 14:16:35.285187    53 pmd.cc:70] 8 DPDK PMD ports have been recognized:
2024-01-10T14:16:35.285Z [bessd] I0110 14:16:35.285219    53 pmd.cc:94] DPDK port_id 0 (net_e1000_igb)   RXQ 16 TXQ 16  1c:fd:08:7c:71:2c  00000000:08:00.00 8086:10c9   numa_node 0
2024-01-10T14:16:35.285Z [bessd] I0110 14:16:35.285230    53 pmd.cc:94] DPDK port_id 1 (net_e1000_igb_vf)   RXQ 2 TXQ 2  4e:75:6e:6d:7d:aa  00000000:09:10.01 8086:10ca   numa_node 0
2024-01-10T14:16:35.285Z [bessd] I0110 14:16:35.285239    53 pmd.cc:94] DPDK port_id 2 (net_e1000_igb_vf)   RXQ 2 TXQ 2  a2:eb:68:65:7f:15  00000000:09:10.03 8086:10ca   numa_node 0
2024-01-10T14:16:35.285Z [bessd] I0110 14:16:35.285248    53 pmd.cc:94] DPDK port_id 3 (net_e1000_igb_vf)   RXQ 2 TXQ 2  8a:a3:83:4c:05:d5  00000000:09:10.05 8086:10ca   numa_node 0
2024-01-10T14:16:35.285Z [bessd] I0110 14:16:35.285257    53 pmd.cc:94] DPDK port_id 4 (net_e1000_igb_vf)   RXQ 2 TXQ 2  06:66:0e:a0:75:6b  00000000:09:10.07 8086:10ca   numa_node 0
2024-01-10T14:16:35.285Z [bessd] I0110 14:16:35.285267    53 pmd.cc:94] DPDK port_id 5 (net_e1000_igb_vf)   RXQ 2 TXQ 2  02:c4:a5:98:9a:64  00000000:09:11.01 8086:10ca   numa_node 0
2024-01-10T14:16:35.285Z [bessd] I0110 14:16:35.285274    53 pmd.cc:94] DPDK port_id 6 (net_e1000_igb_vf)   RXQ 2 TXQ 2  e2:a0:d6:d3:eb:dd  00000000:09:11.03 8086:10ca   numa_node 0
2024-01-10T14:16:35.285Z [bessd] I0110 14:16:35.285282    53 pmd.cc:94] DPDK port_id 7 (net_e1000_igb_vf)   RXQ 2 TXQ 2  56:67:6e:0d:85:ff  00000000:09:11.05 8086:10ca   numa_node 0

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


sudo microk8s ctr image import --base-name docker.io/mbeierl/ueransim /home/ubuntu/git/GitHub/markbeierl/ueransim-rock/ueransim_3.2.6_amd64.rock


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

sudo microk8s ctr image import --base-name docker.io/mbeierl/sdcore-upf-bess ./sdcore-upf-bess_1.3_amd64.rock


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