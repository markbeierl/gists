# DPDK

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

UPF Charm
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





