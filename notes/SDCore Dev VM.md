# SDCore Dev VM

## Redo VM
Sphinx docs
```bash
sudo apt install python3-pip python3.10-venv aspell
```
Tox
```bash
pip install tox
export PATH=/home/ubuntu/.local/bin:$PATH
```

LXD Bridge MTU
```bash
lxc network set lxdbr0 bridge.mtu=1442
```
Crafts
```bash
sudo snap install rockcraft --classic &
sudo snap install snapcraft --classic &
sudo snap install charmcraft --classic
```
Microk8s Group
```bash
sudo usermod -a -G snap_microk8s $USER
```

## Reset Microk8s
```bash
sudo snap remove --purge microk8s & sudo snap remove --purge juju ; wait ; rm -rf ~/.local/share/juju ; sudo init 6
```

```bash
sudo snap install microk8s --channel=1.27-strict/stable & sudo snap install juju --channel=3.1/edge
mkdir -p .local/share/juju
wait
sudo snap alias microk8s.kubectl kubectl
```

```bash
sudo microk8s enable hostpath-storage
juju bootstrap microk8s &
sudo microk8s addons repo add community https://github.com/canonical/microk8s-community-addons --reference feat/strict-fix-multus
sudo microk8s enable multus
wait
```

Really only need 0.6-0.8, but leave more to see what else might get used
```bash
sudo microk8s enable metallb:10.201.0.6-10.201.0.10
juju add-model core
juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1392
```

```bash
juju deploy sdcore --trust --channel=edge
```

## WEBUI
```bash
export WEBUI_IP=10.1.144.233

curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 \
--header 'Content-Type: text/plain' \
--data '{
    "UeId":"208930100007487",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
```
```bash
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
```
```bash
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
      "upf-name": "upf-external",
      "upf-port": "8805"
    }
  }
}'
```

## gNB Sim
Build the UERANSIM Rock
```bash
cd git/GitHub/markbeierl/ueransim-rock
rockcraft pack
```

Load rock into microk8s
```bash
sudo microk8s ctr image import --base-name docker.io/mbeierl/ueransim /home/ubuntu/git/GitHub/markbeierl/ueransim-rock/ueransim_3.2.6_amd64.rock
```

Deploying the Charm.  sdcore router must already be deployed for the gnb nad to pick the address
```bash
cd ~/git/GitHub/markbeierl/ueransim-gnb-operator/
time charmcraft pack
juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/ueransim:3.2.6 --config gnb-address=192.168.251.110/24
juju relate amf ueransim-gnb
```

Check metallb is serving the IP.  The ip shown is used by the UE as the endpoint to connect
```bash
kubectl get services -A | grep ueransim-gnb-external
```

```bash
juju run ueransim-gnb/leader start-radio
```

Enter the container to look around
```bash
kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
```

## UE
_Do not run on the same host or multus looses its mind_

```bash
cd /ceph/git/GitHub/aligungr/UERANSIM
sudo ./build/nr-ue -c config/free5gc-ue.yaml
```
