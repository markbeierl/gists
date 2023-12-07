# Multiple UPFs

## WEBUI
```bash
export WEBUI_IP=10.1.144.233

for IMSI in `seq 7000 7010`; do

curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-20893010000${IMSI} \
--header 'Content-Type: text/plain' \
--data "{
    \"UeId\":\"20893010000${IMSI}\",
    \"opc\":\"981d464c7c52eb6e5036234984ad0bcf\",
    \"key\":\"5122250214c33e723a5dd523fc145fc0\",
    \"sequenceNumber\":\"16f3b3f70fc2\"
}"
done

```
```bash
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows \
--header 'Content-Type: application/json' \
--data '{
    "imsis": [
        "208930100007000",
        "208930100007001",
        "208930100007002",
        "208930100007003",
        "208930100007004",
        "208930100007005",
        "208930100007006",
        "208930100007007",
        "208930100007008",
        "208930100007009",
        "208930100007010",
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
