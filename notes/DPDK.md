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
sudo snap install microk8s --channel=1.29/stable --classic
sudo microk8s enable hostpath-storage
sudo microk8s enable metallb:10.201.0.201-10.201.0.201 &
sudo microk8s addons repo add community \
    https://github.com/canonical/microk8s-community-addons \
    --reference feat/strict-fix-multus
sudo microk8s enable multus
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

# UPF Charm Bare Metal K8s + SR-IOV

## Ryzen Host

```bash
sudo apt install -y driverctl net-tools
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
```

## VF Configuration

For reference

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

## Config Map

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
cat << EOF > upf-dpdk.yaml
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
juju integrate amf:logging grafana-agent-k8s
juju integrate ausf:logging grafana-agent-k8s
juju integrate smf:logging grafana-agent-k8s
```

```bash
juju integrate upf:logging grafana-agent-k8s
```

On the gnbsim VM, run UERANSIM and use:

```bash
sudo ip route add 10.203.0.0/16 dev uesimtun0
ping -I uesimtun0 service-1.core -c 6000 -i .1 -s 36 | grep rtt
```
