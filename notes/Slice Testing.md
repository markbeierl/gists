# Background

This started with me wanting to test the edit functionality of the NMS. The items to change that I was able to test:

- Subscriber IP Pool
- Maximum Bitrate - Downstream
- Maximum Bitrate - Upstream

I was not able to test:

- DNS as the UERANSIM software does not appear to do anything with the information
- MTU

# Issues

## AMBR Findings

- Regardless of edit, the radio always gets the initial slice MBR for down and upstream
- Changes set to lower than the initial (200/20) are eventually effective for the PDU (probably enforced in the UPF via the PFCP) at some pont. (Theory is when the session becomes idle)
- I added a second DG and second subscriber assined to that DG. UE received IP address from default device group, so DG assignment does not appear to work (open upstream bug)

Bugs:
- https://github.com/omec-project/smf/issues/227
- https://github.com/omec-project/smf/issues/228

## Creating the network slice

### Subscribers

```bash
for IMSI in `seq 81 89`; do
  curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-2089301000074${IMSI} \
  --header 'Content-Type: text/plain' \
  --data "{
    \"UeId\":\"2089301000074${IMSI}\",
    \"opc\":\"981d464c7c52eb6e5036234984ad0bcf\",
    \"key\":\"5122250214c33e723a5dd523fc145fc0\",
    \"sequenceNumber\":\"16f3b3f70fc2\"
  }"
done
```

### Device Groups

```bash
curl -v ${WEBUI_IP}:5000/config/v1/device-group/DG-1 \
--header 'Content-Type: application/json' \
--data '{
    "imsis": [
        "208930100007481"
    ],
    "site-info": "site-1",
    "ip-domain-name": "domain1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.1.0.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1348,
        "ue-dnn-qos": {
            "dnn-mbr-uplink":   5,
            "dnn-mbr-downlink": 5,
            "bitrate-unit": "gbps",
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
curl -v ${WEBUI_IP}:5000/config/v1/device-group/DG-2 \
--header 'Content-Type: application/json' \
--data '{
    "imsis": [
        "208930100007482"
    ],
    "site-info": "domain2",
    "ip-domain-name": "pool2",
    "ip-domain-expanded": {
        "dnn": "internet2",
        "ue-ip-pool": "172.2.0.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1348,
        "ue-dnn-qos": {
            "dnn-mbr-uplink":   5,
            "dnn-mbr-downlink": 5,
            "bitrate-unit": "gbps",
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

### Slices

```bash
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/Slice-1 \
--header 'Content-Type: application/json' \
--data '
{
  "SliceName": "Slice-1",
  "slice-id": {
    "sst": "1",
    "sd": "010203"
  },
  "site-device-group": [
    "DG-2",
    "DG-1"
  ],
  "site-info": {
    "site-name": "demo",
    "plmn": {
      "mcc": "208",
      "mnc": "93"
    },
    "gNodeBs": [
      {
        "name": "gnbsim-gnbsim-gnbsim",
        "tac": 1
      }
    ],
    "upf": {
      "upf-name": "upf.mgmt",
      "upf-port": "8805"
    }
  }
}'
```



