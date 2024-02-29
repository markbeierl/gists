# On-Ramp

Quick start: https://docs.aetherproject.org/master/onramp/start.html

```bash
sudo apt update
sudo apt install -y build-essential git iptables libsctp1 openssh-server pipx
pipx install --include-deps 'ansible<2.16'
pipx ensurepath
ansible-galaxy collection install kubernetes.core ansible.utils community.docker
ssh-keygen
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
```

```bash
git clone --recursive https://github.com/opennetworkinglab/aether-onramp.git
cd aether-onramp
```

Change hosts.ini to match the IP of the VM/server
```
node1 ansible_host=10.81.217.248 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
```

Change vars/main.yaml to use the `enp5s0` iface and IP address above

```bash
sed -i "s/ens18/enp5s0/" vars/main.yml
sed -i "s/10.76.28.113/10.81.217.248/" vars/main.yml
```


Test that it works
```bash
make aether-pingall
```

Install K8s and sd-core

```bash
make aether-k8s-install
make aether-5gc-install
make aether-gnbsim-install
```

```bash
make aether-gnbsim-run
docker exec -it gnbsim-1 cat summary.log
```
