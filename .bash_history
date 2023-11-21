ls -lll
\
ls -al /cepj
ls -al /ceph
sudo umount /ceph
sudo mount /ceph
ls -al /ceph
cd /ceph/git/GitHub/canonical/charmed-5g/
cd docs
make spelling
make install
sudo     apt install python3.10-venv
make installl
cat Makefile 
python3 -m venv .sphinx/venv
make clean
make install
make spelling
aspell
sudo apt install aspell
make spelling
ls -al
vi .wordlist.txt 
make spelling
top
cd
df -h .
juju status
juju destroy-model --destroy-storage core
df -h
du --max-depth=1 -h /var
sudo du --max-depth=1 -h /var
sudo du --max-depth=1 -h /
df -h /
sudo du --max-depth=1 -h /var/snap
sudo du --max-depth=1 -h /var/snap/microk8s/
sudo du --max-depth=1 -h /var/snap/microk8s/common/
sudo du --max-depth=1 -h /var/snap/microk8s/common/var
sudo du --max-depth=1 -h /var/snap/microk8s/common/var/lib
sudo du --max-depth=1 -h /var/snap/microk8s/common/var/lib/containerd/
ip link
juju
juju deploy --help
cd canonical/charmed-5g/
cd canonical/sdcore-gnbsim-operator/
tox -e unit
sudo apt install tox
tox -e unit
tox --version
sudo apt purge tox
pip install tox
export PATH=/home/ubuntu/.local/bin:$PATH
tox --version
rm -rf .tox
tox -e unit
cd canonical/sdcore-amf-operator/
git pull
git diff
git restore tox.ini
git pull
cd ../sdcore-gnbsim-operator/
charmcraft pack
docker
lxc --project charmcraft list
lxc --project charmcraft exec charmcraft-sdcore-gnbsim-1099512029993-0-0-amd64 bash
sudo iptables-save
ip addr
lxc network set lxdbr0 bridge.mtu=1234
lxc network set lxdbr0 bridge.mtu=1442
charmcraft pack
ping 10.0.0.10
top
reset
cp canonical/sdcore-ueransim-rock/sdcore-ueransim_3.2.6_amd64.rock .
top
btop
watch -cn.5 juju status --color
microk8s.kubectl get po -A
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
watch -cn.5 juju status --color
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
microk8s.kubectl delete po -n gnbsim sdcore-ueransim-0
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
microk8s.kubectl delete po -n gnbsim sdcore-ueransim-0
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
juju status
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
microk8s.kubectl delete po -n gnbsim sdcore-ueransim-0
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
microk8s.kubectl delete po -n gnbsim sdcore-ueransim-0
juju status
juju remove-application sdcore-ueransim --force
microk8s.kubectl get po -A
microk8s.kubectl get po -A -w
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
sudo apt install docker
sudo microk8s.enable registry
sudo /snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive:dotnet-runtime_chiselled_amd64.rock docker-daemon:dotnet-runtime:chiselled
sudo /snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive: ./sdcore-ueransim_3.2.6_amd64.rock docker-daemon:sdcore-ueransim:3.2.6
skopeo --insecure-policy copy oci-archive:sdcore-ueransim_3.2.6_amd64.rock docker://127.0.0.1:32000/ueransim:3.2.6
/snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive:sdcore-ueransim_3.2.6_amd64.rock docker://127.0.0.1:32000/ueransim:3.2.6
/snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive:sdcore-ueransim_3.2.6_amd64.rock docker://127.0.0.1:32000/ueransim:3.2.6 --help
/snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive:sdcore-ueransim_3.2.6_amd64.rock docker://127.0.0.1:32000/ueransim:3.2.6 --src-no-creds
/snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive:sdcore-ueransim_3.2.6_amd64.rock oci:ueransim:3.2.6.oci 
ls -al
ls -al *.oci
/snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive:sdcore-ueransim_3.2.6_amd64.rock oci:ueransim:3.2.6.oci 
/snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive:sdcore-ueransim_3.2.6_amd64.rock dir:ueransim:3.2.6.oci 
ls -al 
ls -al ueransim
ls -al ueransim\:3.2.6.oci/
/snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive:sdcore-ueransim_3.2.6_amd64.rock docker-archive:sdcore-ueransim.oci
ls -al
docker import
sudo snap install docker         # version 20.10.24, or
sudo /snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive: ./sdcore-ueransim_3.2.6_amd64.rock docker-daemon:sdcore-ueransim:3.2.6
sudo /snap/rockcraft/current/bin/skopeo --insecure-policy copy oci-archive:sdcore-ueransim_3.2.6_amd64.rock docker-daemon:sdcore-ueransim:3.2.6
docker image ls
sudo docker image ls
sudo docker tag
sudo docker tag sdcore-ueransim:3.2.6 localhost:32000/sdcore-ueransim:3.2.6
docker push 32000/sdcore-ueransim
sudo docker push 32000/sdcore-ueransim
sudo docker push localhost:32000/sdcore-ueransim
sudo iptables-save
telnet localhost 32000
sudo docker push localhost:32000/sdcore-ueransim
docker image list
sudo docker image list
sudo docker push localhost:32000/sdcore-ueransim:3.2.6
juju status
watch -cn.5 juju status --color
microk8s.ctr image ls | grep 3.2.6
watch -cn.5 juju status --color
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
ssh control-plane.mgmt
cd ~/canonical/sdcore-gnbsim-operator/
ls -al
juju models
juju status
juju resolve --no-retry upf/0
juju status
juju resolve --no-retry upf/0
juju status
juju remove-application upf --force
juju status
juju resolve --no-retry upf/0
juju status
juju remove-application upf --force --no-wait
juju status
microk8s.kubectl get po -A -w
juju sttaus
juju status
juju add-model gnbsim
ls -al ../sdcore-ueransim-rock/
juju deploy ./sdcore-gnbsim_ubuntu-22.04-amd64.charm 
ls -al ./sdcore-gnbsim_ubuntu-22.04-amd64.charm 
charmcraft pack
ls -al ./sdcore-gnbsim_ubuntu-22.04-amd64.charm 
juju deploy ./sdcore-gnbsim_ubuntu-22.04-amd64.charm 
cd 
cp ~/canonical/sdcore-gnbsim-operator/sdcore-gnbsim_ubuntu-22.04-amd64.charm .
cd -
cd ../sdcore-ueransim-operator/
charmcraft pack
cp sdcore-ueransim_ubuntu-22.04-amd64.charm ~/
cd
juju deploy ./sdcore-gnbsim_ubuntu-22.04-amd64.charm 
rm ./sdcore-gnbsim_ubuntu-22.04-amd64.charm 
juju deploy ./sdcore-ueransim_ubuntu-22.04-amd64.charm 
juju deploy ./sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=./sdcore-ueransim_3.2.6_amd64.rock
microk8s.ctr --help
microk8s.ctr image --help
microk8s.ctr image import ./sdcore-ueransim_3.2.6_amd64.rock 
microk8s.ctr image list
microk8s.ctr image list | grep import
juju deploy ./sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=import-2023-10-31:3.2.6
juju debug-log
juju remove-application ueransim
juju remove-application sdcore-ueransim
cd -
#charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; cd ~
juju resolve sdcore-ueransim/0 --no-retry
juju debug-log
juju resolve sdcore-ueransim/0 --no-retry
# juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=import-2023-10-31:3.2.6
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=import-2023-10-31:3.2.6 ; juju debug-log
juju remove-application sdcore-ueransim
juju resolve sdcore-ueransim/0 --no-retry
tox -e unit
cd ../sdcore-upf-operator/
git status
git diff
git branch
git reset HEAD
git status
git restore .gitignore src/charm.py
git fetach -a
git fetch -a
git pull
cd -
tox -e cover
toe -x unit
tox -e unit
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=import-2023-10-31:3.2.6 ; juju debug-log
ip link
juju debug-log
juju remove-application sdcore-ueransim
juju remove-application sdcore-ueransim --force
juju destroy-model --destroy-storage
juju destroy-model --destroy-storage gnbsim
juju add-model gnbsim
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=import-2023-10-31:3.2.6 ; juju debug-log
juju remove-application sdcore-ueransim
sudo iptables -I DOCKER-USER -i lxdbr0 -j ACCEPT
sudo iptables -I DOCKER-USER -o lxdbr0 -j ACCEPT
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=import-2023-10-31:3.2.6 ; juju debug-log
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=sdcore-ueransim:3.2.6 ; juju debug-log
juju remove-application sdcore-ueransim
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=docker.io/library/sdcore-ueransim ; juju debug-log
#charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=docker.io/library/sdcore-ueransim:3.2.6 ; juju debug-log
juju remove-application sdcore-ueransim
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=docker.io/library/sdcore-ueransim:3.2.6 ; juju debug-log
juju remove-application sdcore-ueransim
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=localhost:32000/sdcore-ueransim:3.2.6 ; juju debug-log
juju remove-application sdcore-ueransim
ls -al 
ls -al ueransim
ls -al ueransim\:3.2.6.oci/
juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=sdcore-ueransim:3.2.6 ; juju debug-log
juju status
watch -cn.5 juju status --color
juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 ; juju debug-log
watch -cn.5 juju status --color
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
microk8s.ctr image list | grep import
microk8s.ctr image list 
watch -cn.5 juju status --color
microk8s.kubectl describe po -n gnbsim sdcore-ueransim-0
sudo snap remove --purge microk8s & sudo snap remove --purge juju
sudo init 6
microk8s.ctr image import --base-name docker.io/mbeierl/sdcore-ueransim ./sdcore-ueransim_3.2.6_amd64.rock 
juju remove-application sdcore-ueransum
juju status
juju remove-application sdcore-ueransim
juju debug-log
#microk8s.ctr image import --base-name docker.io/mbeierl/sdcore-ueransim ./sdcore-ueransim_3.2.6_amd64.rock 
file sdcore-ueransim_3.2.6_amd64.rock 
tar tvf sdcore-ueransim_3.2.6_amd64.rock 
microk8s.ctr image list | grep import
microk8s.ctr image rm import-2023-10-31:3.2.6
microk8s.ctr image rm docker.io/library/import-2023-10-31:3.2.6 
microk8s.ctr image list | grep text
microk8s.ctr image rm docker.io/library/sdcore-ueransim:3.2.6docker.io/library/sdcore-ueransim:3.2.6
microk8s.ctr image rm docker.io/library/sdcore-ueransim:3.2.6
microk8s.ctr image rm docker.io/library/sdcore-ueransim:latest
microk8s.ctr image list | grep beierl
juju status
juju remove-application sdcore-ueransim
microk8s.ctr image rm docker.io/mbeierl/sdcore-ueransim:3.2.6
microk8s.ctr image import --base-name docker.io/mbeierl/sdcore-ueransim ./sdcore-ueransim_3.2.6_amd64.rock 
microk8s.ctr image list | grep beierl
juju status
juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 ; juju debug-log
ls -al ueransim\:3.2.6.oci/
microk8s.ctr image list | grep 5db87f0231ead72696c91af4353d81e7f021594d29e20e9eebfe328c660e9158
cat .bash_history 
sudo snap install juju --channel=3.1/stable
sudo microk8s enable hostpath-storage
sudo microk8s addons repo add community https://github.com/canonical/microk8s-community-addons --reference feat/strict-fix-multus
sudo microk8s enable multus
watch -cn.5 juju status --color
sudo snap remove --purge docker
sudo snap install microk8s --channel=1.27-strict/stable
sudo microk8s enable metallb:10.0.0.2-10.0.0.4
juju bootstrap microk8s
rm -rf .local/share/juju/*
juju bootstrap microk8s
microk8s.ctr image import --base-name docker.io/mbeierl/sdcore-ueransim ./sdcore-ueransim_3.2.6_amd64.rock 
juju add-model gnbsim
juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 ; juju debug-log
juju deploy sdcore-router router --trust --channel=edge
juju config router
reset
juju config router
juju config router ran-interface-mtu-size=1442 core-interface-mtu-size=1442 access-interface-mtu-size=1442
juju status
watch -cn.5 juju status --color
ip link
watch -cn.5 juju status --color
juju remove-application upf
watch -cn.5 juju status --color
juju resolve upf/0 --no-retry
watch -cn.5 juju status --color
juju deploy sdcore --trust --channel=edge
juju debug-log
juju relate amf sdcore-ueransim
juju debug-log
juju remove-application upf
juju debug-log
juju resolve upf/0 --no-retry
juju debug-log
juju remove-application sdcore-ueransim
#charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=localhost:32000/sdcore-ueransim:3.2.6 ; juju debug-log
cd canonical/sdcore-ueransim-rock/
rockcraft pack
cat /home/ubuntu/.local/state/rockcraft/log/rockcraft-20231101-090252.265086.log
lxc --project rockcraft list
sudo apt purge lxd
sudo snap remove --purge lxd
sudo snap install lxd
lxd-init
lxd init
lxc init
lxd init
lxc network set lxdbr0 bridge.mtu=1442
rockcraft pack
cat /home/ubuntu/.local/state/rockcraft/log/rockcraft-20231101-091123.543426.log
ip addr
sudo iptables-save
sudo snap remove --purge docker
sudo init 6
cd canonical/sdcore-ueransim-rock/
rockcraft pack
cat /home/ubuntu/.local/state/rockcraft/log/rockcraft-20231101-091724.101735.log
lxc --all-project list
lxc --all-projects list
lxc list
lxc list --all-projects
lxc exec --project rockcraft base-instance-buildd-base-v2-craft-comub-227887cb69991f9aa924 bash
rockcraft pack
cd ..
sudo iptables-save
btop
sudo mount /ceph
ln -s /ceph/git/GitHub/canonical/ .
cp canonical/.bash_history .
sudo snap install lxd
lxd-init
lxd init
lxc network set lxdbr0 bridge.mtu=1442
sudo snap install rockcraft --channel=edge --classic
sudo snap install snapcraft --classic
sudo snap install charmcraft --classic
sudo usermod -a -G snap_microk8s $USER
sudo snap install microk8s --channel=1.27-strict/stable
groups
sudo microk8s enable hostpath-storage
sudo microk8s addons repo add community https://github.com/canonical/microk8s-community-addons --reference feat/strict-fix-multus
sudo microk8s enable multus
sudo microk8s enable metallb:10.0.10.2-10.0.10.4
watch -cn.5 juju status --color
cd canonical/sdcore-ueransim-operator/
charmcraft pack
sudo snap install juju --channel=3.1/stable
juju bootstrap microk8s
mkdir -p .local/share/juju
juju bootstrap microk8s
juju add-model core
juju deploy sdcore-router router --trust --channel=edge 
juju config router
juju config router access-interface-mtu-size=1392 core-interface-mtu-size=1392 ran-interface-mtu-size=1392
#juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1392
juju status
ip addr
juju status
juju deploy sdcore --trust --channel=edge
cd canonical/sdcore-ueransim-operator/
# charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 ; juju debug-log
microk8s.ctr image import --base-name docker.io/mbeierl/sdcore-ueransim ./sdcore-ueransim_3.2.6_amd64.rock 
cd ../sdcore-ueransim-rock/
ls -al
rockcraft pack
microk8s.ctr image import --base-name docker.io/mbeierl/sdcore-ueransim ./sdcore-ueransim_3.2.6_amd64.rock 
cp ./sdcore-ueransim_3.2.6_amd64.rock ~
cd
microk8s.ctr image import --base-name docker.io/mbeierl/sdcore-ueransim ./sdcore-ueransim_3.2.6_amd64.rock 
# charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 ; juju debug-log
ls -al
cd canonical/sdcore-ueransim-operator/
ls -al
cp ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 ; juju debug-log
sudo snap alias micrko8s.kubectl kubectl
sudo snap alias microk8s.kubectl kubectl
kubectl exec -tin core router-0 -c charm bash
juju status
watch -cn.5 juju status --color
juju relate amf sdcore-ueransim
watch -cn.5 juju status --color
juju relate amf sdcore-ueransim
microk8s.kubectl exec -tin core ueransim -c ueransim bash
microk8s.kubectl exec -tin core ueransim -c ueransim-0 bash
microk8s.kubectl exec -tin core sdcore-ueransim-0 -c ueransim bash
top
export WEBUI_IP=10.1.144.234
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "plmnId":"20801",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
top
microk8s.kubectl exec -tin core sdcore-ueransim-0 -c ueransim bash
juju config sdcore-gnbsim
juju config sdcore-ueransim
juju remove-application sdcore-gnbsim
juju remove-application sdcore-ueransim
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
cd canonical/sdcore-ueransim-operator/
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju relate amf sdcore-ueransim
kubectl logs -c core amf-0 -c amf
kubectl get po -a
kubectl get po -A
kubectl logs -n core amf-0 -c amf
microk8s.kubectl exec -tin core sdcore-ueransim-0 -c ueransim bash
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju remove-application sdcore-ueransim
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
microk8s.kubectl exec -tin core sdcore-ueransim-0 -c ueransim bash
ls -al /var/lib/apt/lists
microk8s.kubectl exec -tin core sdcore-ueransim-0 -c ueransim bash
ssh control-plane.mgmt
FIP=gnbsim.mgmt
FIP=juju-controller.mgmt
ssh gnbsim.mgmt
ssh access-core-router.mgmt
ssh ran-access-router.mgmt
juju status
juju remove-application sdcore-ueransim
cd canonical/sdcore-ueransim-operator/
charmcraft pack #; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
ssh ueransim.mgmt
ssh gnbsim.mgmt
ssh juju-controller.mgmt
ip addr
sudo vi /etc/netplan/
sudo vi /etc/netplan/50-cloud-init.yaml 
sudo netplan apply
ip route
ssh juju-controller.mgmt
ls -al .ssh
cp /ceph/.ssh/id_rsa .ssh/
ssh juju-controller.mgmt
microk8s.kubectl exec -tin core sdcore-ueransim-0 -c charm bash
microk8s.kubectl exec -tin core sdcore-ueransim-0 -c charm bash
juju status
microk8s.kubectl exec -tin core sdcore-ueransim-0 -c charm bash \
juju status
juju resolve mongodb-k8s --no-retty
juju resolve mongodb-k8s --no-retry
juju status
juju resolve mongodb-k8s/0 --no-retry
juju status
juju resolve mongodb-k8s/0 --no-retry
juju status
juju resolve mongodb-k8s/0 --no-retry
top
watch -cn.5 juju status --color
top
juju status
juju destroy-model --destroy-storage core --no-prompt
ssh ubuntu@control-plane.mgmt
juju status
juju add-model core
#juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1392
#juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1442
ip add
juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1392
juju status
ip addr
juju deploy sdcore --trust --channel=edge
top
btop
sudo snap install btop
export WEBUI_IP=10.1.144.205
btop
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "plmnId":"20801",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
btop
juju deploy sdcore-gnbsim gnbsim --trust --channel=edge
juju integrate gnbsim:fiveg-n2 amf:fiveg-n2
kubectl get po -A
microk8s.kubectl exec -tin core gnbsim-0 -c charm bash 
watch -cn.5 juju status --color
juju run gnbsim/leader start-simulation
scp ueransim.mgmt:*.pcap .
cd /ceph/git/GitHub/omec-project/
ls -al
cd smf
make
sudo apt install make        # version 4.3-4.1build1, or
make golint
ls -al
make
go
sudo snap install go         # version 1.21.3, or
sudo snap install go --classic        
make
make golint
go build
ssh control-plane.mgmt
scp -r /etc/ceph ueransim:
scp -r /etc/ceph ueransim.mgmt:
cat /etc/fstab 
cat /ceph/git/GitHub/canonical/sdcore-ueransim-rock/rockcraft.yaml 
btop
top
juju status
ssh ueransim
ssh ueransim.mgmt
ssh juju-controller.mgmt
ssh control-plane.mgmt
ssh ueransim
ssh ueransim.mgmt
ssh control-plane.mgmt
juju status
juju destroy-model core --no-prompt --destroy-storage
ssh control-plane.mgmt
cd /ceph/git/GitHub/omec-project/amf/
grep -ri ambr ngap/
grep -ri ambr .
grep -ri pdu .
grep -ri 130 .
grep -ri pdusession .
grep -ri pdusessionaggregate .
grep -ri pdusessiona .
grep -ri pdusession .
grep -r CriticalityPresentIgnore *
cd ..
cd /ceph/git/GitHub/omec-project/
gh repo clone omec-project/amf
git clone https://github.com/omec-project/amf.git
ssh juju-controller.mgmt
ssh control-plane.mgmt
scp control-plane.mgmt:amf.pcap .
ssh ueransim.mgmt
ssh ueransim.mgmt
ssh control-plane.mgmt
ssh control-plane.mgmt
ssh core-router.mgmt
cd /ceph/git/osm/branches/master/devops/installers/charm/bundles/osm
ls -al
vi bundle.yaml 
juju deploy --help
ssh control-plane.mgmt
ssh juju-controller.mgmt
ssh juju-controller.mgmt
ssh core-router.mgmt
scp .ssh/id_rsa core-router.mgmt:.ssh/
ssh core-router.mgmt
juju status
juju resolve --no-retry mongodb-k8s/0
juju status
juju resolve --no-retry mongodb-k8s/0
juju status
juju resolve --no-retry mongodb-k8s/0
juju status
juju resolve --no-retry mongodb-k8s/0
juju status
juju resolve --no-retry mongodb-k8s/0
juju status
ssh control-plane.mgmt
ssh ue-1
ssh ue-1.mgmt
ssh ueransim.mgmt
ping ue-1.mgmt
ping ue-2.mgmt
ssh ue-2.mgmt
ssh 10.201.1.248
ssh juju-controller.mgmt
ssh ueransim.mgmt
ssh ueransim.mgmt
ssh ue-2.mgmt
ssh juju-controller.mgmt
top
ping 10.201.0.101
ping 10.201.0.10
host 10.201.0.10
ssh juju-controller.mgmt
ssh control-plane.mgmt
cd canonical/ueransim-gnb-operator/
time charmcraft pack
juju status
juju add-model core
juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1442
grep deploy ~/.bash_history
charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju debug-log
juju status
grep amf ~/.bash_history
juju deploy amf ; juju config amf
juju deploy sdcore-amf ; juju config sdcore-amf
juju deploy sdcore-amf --channel=latest/edge ; juju config sdcore-amf
juju config amf external-amf-hostname=localhost external-amf-ip=127.0.0.1
juju config sdcore-amf external-amf-hostname=localhost external-amf-ip=127.0.0.1
juju status
juju relate sdcore-amf sdcore-ueransim
juju status
juju remove-application sdcore-ueransim
juju remove-application sdcore-amf
grep deploy ~/.bash_history
juju deploy sdcore --trust --channel=edge
juju status
watch -cn.5 juju status --color
juju status
export WEBUI_IP=10.1.144.216
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "plmnId":"20801",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
kubectl get po -A
microk8s.kubectl exec -tin core router-0 bash
cd ..
ls -al
git clone https://github.com/canonical/ip-router-interface.git
cd ip-router-interface/
git branch -r
git checkout origin/propagate-network-names 
tox -e integration
pip install tox
sudo apt install python3-pip
pip install tox
tox -e integration
export PATH=$PATH:~/.local/bin
tox -e integration
juju models
juju status
juju models
juju switch test-integration-irio
juju status
btop
juju status
watch -cn.5 juju status --color
juju models
juju switch core
btop
ssh ue-2
ssh ue-2.mgmt
scp -r /etc/ceph ue-2.mgmt:
ssh ue-2.mgmt
ping ue-2.mgmt
ssh ue-2.mgmt
ping ue-2.mgmt
ssh ue-2.mgmt
ssh user-plane.mgmt
ssh ueransim.mgmt
reset
juju status
juju debug-log
juju debug-log --replay
top
juju status
juju scale-application upf 0
top
juju status
juju scale-application webui 0
top
juju scale-application webui 1
top
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
juju status
export WEBUI_IP=10.1.144.229
cat .bash_history
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "plmnId":"20801",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
top
kubectl logs -n core amf-0 -c amf
ssh control-plane.mgmt
cd /ceph/git
ls -al
ls -al GitHub/
ssh ueransim.mgmt
ls -al /ceph
ls -al /ceph/git/
cp /ceph/git/.git* .
gh
sudo snap install gh       # version 2.6.0-15-g1a10fd5a, or
gh repo clone omec-project/nrf
gh auth login
#gh repo clone omec-project/nrf
cd /ceph/git/GitHub/omec-project/
#gh repo clone omec-project/nrf
gh repo clone omec-project/nrf
sudo vi /etc/fstab 
cd
mkdir git
sudo mount git
sudo mount /home/ubuntu/git
ls -al
ls -al git
cat /etc/fstab 
mount /home/ubuntu/git
sudo mount /home/ubuntu/git
sudo vi /etc/fstab 
sudo mount /home/ubuntu/git
cd git/GitHub/omec-project/
gh repo clone omec-project/nrf
ls -al ~/.ssh/
rsync -avt /ceph/.ssh ~/.ssh
ls -al ~/.ssh/
rsync -avt /ceph/.ssh ~/
ls -al ~/.ssh/
gh repo clone omec-project/nrf
snap connect gh:ssh-keys
sudo snap connect gh:ssh-keys
gh repo clone omec-project/nrf
vi ~/.ssh/config
gh repo clone omec-project/nrf
gh repo clone omec-project/util
ssh juju-controller.mgmt
ssh ueransim.mgmt
cat .bash_history 
juju scale-application webui 0
juju scale-application webui 1
export WEBUI_IP=10.1.144.235
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "plmnId":"20801",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
top
ssh juju-controller.mgmt
juju status
btop
kubectl exec -tin core webui bash
kubectl exec -tin core webui-0 bash
jhack --help
sudo snap install jhack
jhack
sudo snap connect jhack:dot-local-share-juju snapd
juju scp
juju scp --help
juju scp webui/0:*.pcap /ceph/tmp/
juju scp webui/0:webui.pcap /ceph/tmp
ls -al /ceph/tmp/
ls -al /ceph/
juju scp webui/0:webui.pcap .
ls -al .
juju scp webui/0:webui.pcap -c charm .
#juju scp webui/0:webui.pcap .
juju ssh webui/0
#juju scp webui/0:grpc.pcap .
juju scp webui/0:grpc.pcap .
juju scp webui/0:grpc.pcap ./grpc.pcap
juju scp webui/0:grpc.pcap /ceph/tmp/grpc.pcap
mv grpc.pcap /ceph/tmp
kubectl logs -n core amf-0 -c amf
kubectl exec -tin core webui-0 bash
juju status
kubectl exec -tin core webui-0 bash
juju scp webui/0:grpc.pcap /ceph/tmp/grpc.pcap
juju scp webui/0:grpc.pcap ./grpc.pcap
mv grpc.pcap /ceph/tmp
juju status
ssh gnbsim.mgmt
ssh ue-2
ssh ue-2.mgmt
#charmcraft pack ; mv ./sdcore-ueransim_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/sdcore-ueransim_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
cd canonical/ueransim-gnb-operator/
ls -al
rm ~/sdcore-ueransim_*
charmcraft pack ; mv ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju status --watch
juju status --help
juju status --help 1s
juju status --watch 1s
juju debug-log
#juju remove-application 
juju status
juju remove-application ueransim-gnb-operator
juju status --watch 1s
juju resolve ueransim-gnb-operator/0 --no-retry
juju status --watch 1s
juju resolve ueransim-gnb-operator/0 --no-retry
juju status --watch 1s
juju resolve ueransim-gnb-operator/0 --no-retry
juju status
cd ..
ls -al
grep stored * -r
grep StoredState * -r
view mongodb-k8s-operator/lib/charms/prometheus_k8s/v0/prometheus_scrape.py
cd ueransim-gnb-operator/
charmcraft pack ; cp ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju debug-log
juju remove-application ueransim-gnb-operator
juju resolve ueransim-gnb-operator/0 --no-retry
charmcraft pack ; cp ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju status --watch 1s
juju debug-log
juju remove-application ueransim-gnb-operator
juju resolve ueransim-gnb-operator/0 --no-retry
time charmcraft pack ; cp ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju debug-log
juju status
juju relate sdcore-amf ueransim-gnb-operator
juju relate amf ueransim-gnb-operator
juju status
juju debug-log
juju run ueransim-gnb-operator/leader start-radio
juju debug-log
kubectl get po -A
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju run ueransim-gnb-operator/leader stop-radio
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju debug-log
juju remove-application ueransim-gnb-operator
juju status --watch 1s
time charmcraft pack ; cp ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju run ueransim-gnb-operator/leader start-radio
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju remove-application ueransim-gnb-operator
juju status --watch 1s
#time charmcraft pack ; rm ~/ueransim-gnb-operator_ubuntu-22.04-amd64.charm ; cp -v ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm ~/ ; juju deploy ~/ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
cd
sudo vi /etc/fstab 
cd git/GitHub/canonical/ueransim-gnb-operator/
time charmcraft pack ; juju deploy ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju status
juju relate amf ueransim-gnb-operator
juju status
#juju run ueransim-gnb-operator/leader start-radio
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju run ueransim-gnb-operator/leader start-radio
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju run ueransim-gnb-operator/leader stop-radio
juju status
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju remove-application ueransim-gnb-operator
time charmcraft pack ; juju deploy ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju status --watch 1s
juju relate amf ueransim-gnb-operator
juju status --watch 1s
juju run ueransim-gnb-operator/leader start-radio
juju run ueransim-gnb-operator/leader stop-radio
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju run ueransim-gnb-operator/leader start-radio
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c charm bash
juju run ueransim-gnb-operator/leader stop-radio
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c charm bash
kubectl get services -A
ping 10.0.10.2
ping 10.0.10.3
ping 10.0.10.4
juju remove-application ueransim-gnb-operator
time charmcraft pack ; juju deploy ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju status
juju relate amf ueransim-gnb-operator
juju status
kubectl get services -A
juju run ueransim-gnb-operator/leader start-radio
#sudo tcpdump -ni 
ip addr
#juju remove-application ueransim-gnb-operator
juju status
juju remove-application ueransim-gnb-operator
sudo microk8s enable metallb:10.0.10.2-10.0.10.2,10.201.0.6-10.201.0.6
sudo microk8s disable metallb
sudo microk8s enable metallb:10.0.10.2-10.0.10.2,10.201.0.6-10.201.0.6
time charmcraft pack ; juju deploy ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
juju status --watch 1s
juju relate amf ueransim-gnb-operator
kubectl get services -A
juju run ueransim-gnb-operator/leader start-radio
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c charm bash
juju debug-log
juju status
kubectl get services -A
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c charm bash
juju run ueransim-gnb-operator/leader start-radio
juju debug-log
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c charm bash
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
cd git/GitHub/aligungr/UERANSIM/
vi config/free5gc-ue.yaml 
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
sudo tcpdump -ni any udp&
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
fg
sudo tcpdump -ni ens3 udp&
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
fg
sudo tcpdump -ni ens4 udp&
sudo tcpdump -ni ens8 udp&
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
fg
sudo tcpdump -ni lo udp&
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
fg
cd git/GitHub/aligungr/UERANSIM/
vi config/free5gc-ue.yaml 
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
#sudo microk8s enable metallb:10.0.10.2-10.0.10.2,10.201.0.6-10.201.0.6
cat ~/git/GitHub/aligungr/UERANSIM/config/free5gc-gnb.yaml 
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju status
ip addr
#sudo microk8s enable metallb:10.0.10.2-10.0.10.2,10.201.0.6-10.201.0.6
sudo microk8s disable metallb
sudo microk8s enable metallb:10.201.0.6-10.201.0.8
kubectl get services -A
sudo tcpdump -ni ens8 udp
sudo tcpdump -ni ens3 udp
sudo tcpdump -ni lo udp
nc
nc -u
nc -u 10.201.0.6 4997
nc -u 10.201.0.7 4997
nc -u 10.0.0.2 53
man nc
nc -u 10.0.0.2 53
sudo tcpdump -ni any icmp
sudo tcpdump -ni any icmp or arp
~/git/GitHub/aligungr/UERANSIM
cd ~/git/GitHub/aligungr/UERANSIM
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
cd ~/git/GitHub/aligungr/UERANSIM
vi config/free5gc-gnb.yaml 
ssh ue-1.mgmt
ssh ue-2.mgmt
ps auxw
cd ~/git/GitHub/aligungr/UERANSIM
vi config/free5gc-gnb.yaml 
./build/nr-gnb -c config/free5gc-gnb.yaml 
sudo tcpdump -ni ens8
cd git/GitHub/aligungr/UERANSIM/
./build/nr-gnb -c ./config/free5gc-gnb.yaml 
sudo apt install libsctp1
./build/nr-gnb -c ./config/free5gc-gnb.yaml 
vi config/free5gc-gnb.yaml g
cd ~/git/GitHub/aligungr/UERANSIM
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju status
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
juju relate amf ueransim-gnb-operator
juju relate amf ueransim-gn
juju relate amf ueransim-gnb

microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
juju debug-log
juju status
kubectl get po -A
microk8s.kubectl describe po -n gnbsim ueransim-gnb-0
microk8s.kubectl describe po -n core ueransim-gnb-0
juju status
juju status~.
ps auxww
ps auxww | grep nr
sudo 966981kill 
sudo kill 966981 
ps auxww | grep nr
ssh ue-2.mgmt
ssh ueransim.mgmt
cd git/GitHub/canonical/ueransim-gnb-operator/
cd ~/git/GitHub/canonical/ueransim-gnb-operator
kubectl get services -A
ping 10.0.10.2
sudo microk8s disable metallb
kubectl get services -A
sudo microk8s enable metallb:10.0.10.2-10.0.10.5
kubectl get services -A
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
ssh ue-2.mgmt
ssh ue-2.mgmt
cd git/GitHub/aligungr/UERANSIM/
vi config/free5gc-ue.yaml 
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
ip addr
ip route
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
cat config/free5gc-ue.yaml 
sudo tcpdump -ni ens8 udp
kubectl get services -A
sudo tcpdump -ni ens3 udp
sudo tcpdump -ni lo udp
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
ip addr
ping 10.0.0.2
ping 10.201.0.6
ping 10.201.0.7
ip addr
cd ~/git/GitHub/aligungr/UERANSIM
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
./build/nr-gnb -c config/free5gc-gnb.yaml 
ps auxww | grep gnb
kill 1128430
ps auxww | grep gnb
kill 1083690
juju run ueransim-gnb-operator/leader stop-radio
ps auxww | grep gnb
./build/nr-gnb -c config/free5gc-gnb.yaml
juju run ueransim-gnb-operator/leader start-radio
#kubectl logs -n core ueransim-gnb -c amf
juju status
kubectl logs -n core ueransim-gnb-operator -c ueransim
kubectl logs -n core ueransim-gnb-operator-0 -c ueransim
kubectl logs --tail 50 --follow -n core ueransim-gnb-operator-0 -c ueransim
juju run ueransim-gnb-operator/leader start-radio
kubectl logs --tail 50 --follow -n core ueransim-gnb-operator-0 -c ueransim
ps auxww | grep nr
kubectl logs --tail 50 --follow -n core ueransim-gnb-operator-0 -c ueransim
juju run ueransim-gnb-operator/leader stop-radio
juju debug-log
kubectl logs --tail 50 --follow -n core ueransim-gnb-operator-0 -c ueransim
juju remove-application ueransim-gnb-operator
kubectl logs --tail 50 --follow -n core ueransim-gnb-operator-0 -c ueransim
juju status
kubectl exec -tin core webui-0 bash
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
juju status
juju config ueransim-gnb
juju config ueransim-gnb gnb-gtp-address=10.1.144.218 gnb-link-address=10.1.144.218
juju config ueransim-gnb gnb-gtp-address=10.1.144.218/24 gnb-link-address=10.1.144.218/24
#time charmcraft pack ; juju deploy ./ueransim-gnb-operator_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
cd git/GitHub/canonical/ueransim-gnb-operator/
rm *.charm
#cd git/GitHub/canonical/ueransim-gnb-operator/
ip addr
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
ssh ue-1.mgmt
ssh ue-2.mgmt
sudo iptables-legacy-save | grep 4997
sudo tcpdump -ni any icmp or arp
ip addr| grep 00:16:3e:8b:06:25
microk8s.kubectl describe po -n core ueransim-gnb-0
juju remove-application ueransim-gnb-operator
juju remove-application ueransim-gnb
juju status
kubectl get po -A -w
kubectl get po -A 
kubectl delete po -n core ueransim-gnb-0
kubectl get po -A 
juju remove-application ueransim-gnb --force
kubectl get po -A 
kubectl delete po -n core ueransim-gnb-0
kubectl get po -A 
juju remove-application ueransim-gnb --force --no-wait
kubectl get po -A 
cd git/GitHub/canonical/ueransim-gnb-operator/
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 -
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 
juju relate amf ueransim-gnb
microk8s.kubectl exec -tin core ueransim-gnb-operator-0 -c ueransim bash
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
kubectl get po -A 
microk8s.kubectl describe po -n core ueransim-gnb-0
juju remove-application ueransim-gnb --force --no-wait
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
kubectl get po -A  -w
kubectl delete po -n core ueransim-gnb-0
juju remove-application ueransim-gnb --force 
kubectl get po -A  -w
microk8s.kubectl describe po -n core ueransim-gnb-0
kubectl delete po -n core ueransim-gnb-0
microk8s.kubectl describe po -n core ueransim-gnb-0
kubectl -n core get all
microk8s.kubectl describe po -n core ueransim-gnb-0
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-gtp-address=192.168.251.100/24 --config gnb-link-address=192.168.251.100/24
kubectl get po -A  -w
microk8s.kubectl describe po -n core ueransim-gnb-0
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-address=192.168.251.100/24 
juju remove-application ueransim-gnb
juju status
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-address=192.168.251.100/24 
juju status
juju debug-log
juju remove-application ueransim-gnb
juju resolve ueransim-gnb/0 --no-retry
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-address=192.168.251.100/24 
ssh ue-2.mgmt
watch -cn.5 juju status --color
juju relate amf ueransim-gnb
nc -u 10.201.0.7 4997
vi .bash_history 
ip addr
juju ssh ueransim/0
juju ssh ueransim-gnb/0
juju scp ueransim-gnb/0:setup.pcap ./setup.pcap
ls -al setup.pcap 
juju run ueransim-gnb/leader stop-radio
juju run ueransim-gnb/leader start-radio
ssh ue-2.mgmt
watch -cn.5 juju status --color
ssh ue-2.mgmt
juju remove-application ueransim-gnb
cd git/GitHub/canonical/ueransim-gnb-operator/
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-address=192.168.251.100/24 
juju debug-log
juju status
juju relate amf ueransim-gnb
juju run ueransim-gnb-operator/leader start-radio
juju run ueransim-gnb/leader start-radio
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
juju ssh ueransim-gnb/0
juju scp ueransim-gnb/0:setup.pcap ./setup.pcap
ls -al seup.pcap
ls -al steup.pcap
date
ls -al setup.pcap
ip link
microk8s.kubectl exec -tin core upf-0 -c charm bash
juju status
juju scale-application upf 1
top
juju status
juju debug-log
juju status
kubectl get po -A  -w
microk8s.kubectl describe po -n core upf-0
juju destroy-model core --no-prompt
juju destroy-model core --no-prompt --destroy-storage
juju add-model core
juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1442
microk8s.kubectl exec -tin core router-0 -c charm bash
grep "deploy sdc" ~/.bash_history 
juju deploy sdcore --trust --channel=edge
juju status
export WEBUI_IP=10.1.144.235
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "plmnId":"20801",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
top
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-address=192.168.251.100/24 
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-address=192.168.251.110/24 
juju status
juju relate amf ueransim-gnb
juju status
juju run ueransim-gnb/leader start-radio
kubectl get services -A
ssh ue-2.mgmt
ls -al
ls -alls -al
ssh ue-2.mgmt
cd ~/git/GitHub/canonical/ueransim-gnb-operator
juju status
juju relate amf ueransim-gnb
juju status
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
juju run ueransim-gnb-operator/leader start-radio
juju run ueransim-gnb/leader start-radio
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
sudo tcpdump -ni ens3 udp
sudo tcpdump -ni ens4 udp
sudo tcpdump -ni ens8 udp
juju run ueransim-gnb/leader stop-radio
juju run ueransim-gnb/leader start-radio
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
microk8s.kubectl exec -tin core ueransim-gnb-0 -c charm bash
cd ~/git/GitHub/canonical/ueransim-gnb-operator
ping 8.8.8.8
cd git/GitHub/canonical/ueransim-gnb-operator/
tox -e unit
. .tox/unit/bin/activate
coverage run --source=/home/ubuntu/git/GitHub/canonical/ueransim-gnb-operator/src/ -m pytest /home/ubuntu/git/GitHub/canonical/ueransim-gnb-operator/tests/unit/ -v --tb native -s
pip install coverage
coverage run --source=/home/ubuntu/git/GitHub/canonical/ueransim-gnb-operator/src/ -m pytest /home/ubuntu/git/GitHub/canonical/ueransim-gnb-operator/tests/unit/ -v --tb native -s
deactivate 
tox -e unit --recreate
grep self.model.get_binding ../* -r
cd git/GitHub/canonical/
gh repo clone canonical/sdcore-smf-operator/
gh repo clone canonical/sdcore-smf-operator
gh repo clone canonical/sdcore-nrf-operator
#gh repo clone canonical/sdcore--operator
juju status
#gh repo clone canonical/sdcore-ausf-operator
u
cd git/GitHub/canonical/
juju status
#gh repo clone canonical/sdcore-pcf-operator
gh repo clone canonical/sdcore-pcf-operator
gh repo clone canonical/sdcore-udm-operator
gh repo clone canonical/sdcore-udr-operator
cd ueransim-gnb-operator/
tox -e unit
#grep self.model.get_binding ../*/
grep -r self.model.get_binding ../*/tests/
code ../mongodb-k8s-operator/tests/unit/helpers.py
view ../mongodb-k8s-operator/tests/unit/helpers.py
grep -r get_binding ../*/tests/
grep -r get_binding ../*/src/
top
juju status
top
kubectl get po -A
#sudo ./build/nr-ue -c config/free5gc-ue.yaml 
#grep self.model.get_binding ../*/
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
cd ~/git/GitHub/aligungr/UERANSIM
#sudo ./build/nr-ue -c config/free5gc-ue.yaml 
ip addr
kubectl get services -A
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
bg
ping 8.8.8.8
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
kubectl get po -A
microk8s.kubectl describe po -n core upf-0
kubectl get po -A -w
microk8s.kubectl describe po -n kube-system kube-multus-ds-xmxvr
juju status
sudo init 6
kubectl get po -A -w
# sudo microk8s enable metallb:10.201.0.6-10.201.0.8
#juju destroy-model core --destroy-storage --
microk8s.kubectl describe po -n kube-system kube-multus-ds-xmxvr
sudo snap remove --purge microk8s & sudo snap remove --purge juju ; wait ; rm -rf ~/.local/share/juju
top
sudo init 6
ls -al git/GitHub
sudo snap install microk8s --channel=1.27-strict/stable
sudo microk8s enable hostpath-storage
snap info juju
sudo snap install juju --channel=3.2/stable
sudo snap remove juju 
sudo snap install juju --channel=3.1/edge
juju bootstrap microk8s
juju add-model core
juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1442
ip addr
juju deploy sdcore --trust --channel=edge
juju config sdcore-router
top
kubectl get po -A -w
sudo snap alias microk8s.kubectl kubectl
kubectl get po -A -w
ip addr
juju run ueransim-gnb/leader start-radio
#time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-address=192.168.251.110/24 
cd ~/git/GitHub/aligungr/UERANSIM
#sudo microk8s ctr image import --base-name docker.io/mbeierl/ueransim:3.2.6 /home/ubuntu/git/GitHub/canonical/sdcore-ueransim-rock/
top
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
export WEBUI_IP=10.1.144.235
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
juju status
export WEBUI_IP=10.1.144.241
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
juju stauts
juju status
fg
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
juju status
top
juju status
juju scale-application upf 0
juju status
juju scale-application upf 1
watch -cn.5 juju status --color
kubectl get po -A -w
microk8s.kubectl describe po -n core upf-0
juju config upf
juju config upf access-interface-mtu-size=1392 core-interface-mtu-size=1392 
microk8s.kubectl describe po -n core upf-0
kubectl get network-attachment-definition -A
juju destroy-model core --no-prompt --destroy-storage
export WEBUI_IP=10.1.144.235
watch -cn.5 juju status --color
sudo ./build/nr-ue -c config/free5gc-ue.yaml 
sudo microk8s addons repo add community https://github.com/canonical/microk8s-community-addons --reference feat/strict-fix-multus
sudo microk8s enable multus
sudo microk8s enable metallb:10.201.0.6-10.201.0.8
watch -cn.5 juju status --color
export WEBUI_IP=10.1.144.235
juju status
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
juju config router
juju config router ran-interface-mtu-size=1392
juju status
watch -cn.5 juju status --color
cd git/GitHub/canonical/ueransim-gnb-operator/
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/sdcore-ueransim:3.2.6 --config gnb-address=192.168.251.110/24 
cd ..
mv sdcore-ueransim-rock/ ueransim-rock
cd ueransim-rock/
rockcraft pack
sudo microk8s ctr image import --base-name docker.io/mbeierl/ueransim:3.2.6 /home/ubuntu/git/GitHub/canonical/ueransim-rock/ueransim_3.2.6_amd64.rock 
cd git/GitHub/canonical/ueransim-gnb-operator/
cd ~/git/GitHub/canonical/ueransim-gnb-operator/
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/ueransim:3.2.6 --config gnb-address=192.168.251.110/24
juju status
sudo microk8s ctr image import --base-name mbeierl/ueransim:3.2.6 /home/ubuntu/git/GitHub/canonical/ueransim-rock/ueransim_3.2.6_amd64.rock 
juju status
microk8s.kubectl describe po -n core ueransim-gnb-0
kubectl get po -A -w
microk8s.kubectl describe po -n core ueransim-gnb-0
sudo microk8s ctr image import --base-name docker.io/mbeierl/ueransim /home/ubuntu/git/GitHub/canonical/ueransim-rock/ueransim_3.2.6_amd64.rock 
microk8s.kubectl describe po -n core ueransim-gnb-0
microk8s.ctl image ls
microk8s ctr image ls
microk8s ctr image ls | grep ueran
microk8s.kubectl describe po -n core ueransim-gnb-0
juju status
juju relate amf ueransim-gnb
juju status
kubectl get services -A
kubectl get services -A | grep ueransim-gnb-external
juju run ueransim-gnb/leader start-radio
juju status
juju debug-log
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim bash
ip addr
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim pebble logs
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim pebble logs --follow
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim -- pebble logs --follow
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/ueransim:3.2.6 --config gnb-address=192.168.251.110/24
top
juju debug-log
juju status
juju relate amf ueransim-gnb
juju run ueransim-gnb/leader start-radio
juju debug-log
microk8s.kubectl exec -tin core ueransim-gnb-0 -c ueransim -- pebble logs --follow
dmesg
sudo dmesg
sudo tail -400f /var/log/syslog
juju debug-log
kubectl get po -A
sudo snap remove --purge microk8s & sudo snap remove --purge juju ; wait ; rm -rf ~/.local/share/juju ; sudo init 6
kubectl get po -A -w
microk8s.kubectl describe po -n core upf-0
juju scale-application upf 0
microk8s.kubectl describe po -n core upf-0
free -h
cat /proc/cpuinfo 
ip addr
juju scale-application upf 1
watch -cn.5 juju status --color
juju debug-log
lsb_release -sd
juju version
juju status
microk8s version
juju model-config logging-config="<root>=INFO;unit=DEBUG"
juju debug-log --replay > log.txt
cat log.txt 
mv log.txt git/
juju resolve --no-retry mongodb-k8s/0
watch -cn.5 juju status --color
juju add-model core
juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1392
juju deploy sdcore --trust --channel=edge
juju debug-log
microk8s.kubectl exec -tin core router-0 -c charm bash
export WEBUI_IP=10.1.144.255
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
top
sudo snap install microk8s --channel=1.27-strict/stable & sudo snap install juju --channel=3.1/edge
wait
sudo snap alias microk8s.kubectl kubectl
sudo microk8s enable hostpath-storage
juju bootstrap microk8s
sudo microk8s addons repo add community https://github.com/canonical/microk8s-community-addons --reference feat/strict-fix-multus
sudo microk8s enable multus
bg
sudo microk8s enable metallb:10.201.0.6-10.201.0.8
juju add-model core\
juju add-model core
juju deploy sdcore-router router --trust --channel=edge --config access-interface-mtu-size=1392 --config core-interface-mtu-size=1392 --config ran-interface-mtu-size=1392
juju deploy sdcore --trust --channel=edge
kubectl get po -A -w
watch -cn.5 juju status --color
top
kubectl get po -A -w
ip addr
tail -f /var/log/syslog
juju status
juju debug-log
juju config router access-interface-mtu-size=1392  core-interface-mtu-size=1392  ran-interface-mtu-size=1392
juju config router access-interface-mtu-size=1390  core-interface-mtu-size=1390  ran-interface-mtu-size=1390
juju status
ip link
watch -cn.5 juju status --color
sudo snap remove --purge microk8s & sudo snap remove --purge juju ; wait ; rm -rf ~/.local/share/juju ; sudo init 6
watch -cn.5 juju status --color
export WEBUI_IP=10.1.144.233
curl -v ${WEBUI_IP}:5000/api/subscriber/imsi-208930100007487 --header 'Content-Type: text/plain' --data '{
    "UeId":"208930100007487",
    "opc":"981d464c7c52eb6e5036234984ad0bcf",
    "key":"5122250214c33e723a5dd523fc145fc0",
    "sequenceNumber":"16f3b3f70fc2"
}'
curl -v ${WEBUI_IP}:5000/config/v1/device-group/cows --header 'Content-Type: application/json' --data '{
    "imsis": [
        "208930100007487"
    ],
    "site-info": "demo",
    "ip-domain-name": "pool1",
    "ip-domain-expanded": {
        "dnn": "internet",
        "ue-ip-pool": "172.250.1.0/16",
        "dns-primary": "8.8.8.8",
        "mtu": 1460,
        "ue-dnn-qos": {
            "dnn-mbr-uplink": 20000000,
            "dnn-mbr-downlink": 200000000,
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
curl -v ${WEBUI_IP}:5000/config/v1/network-slice/default --header 'Content-Type: application/json' --data '{
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
sudo microk8s ctr image import --base-name docker.io/mbeierl/ueransim /home/ubuntu/git/GitHub/canonical/ueransim-rock/ueransim_3.2.6_amd64.rock
\
cd ~/git/GitHub/canonical/ueransim-gnb-operator/
time charmcraft pack ; juju deploy ./ueransim-gnb_ubuntu-22.04-amd64.charm --resource ueransim-image=mbeierl/ueransim:3.2.6 --config gnb-address=192.168.251.110/24
bg
top
juju status
