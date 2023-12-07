# On-Ramp

Quick start: https://docs.aetherproject.org/master/onramp/start.html

```bash
sudo apt install pipx sshpass python3.8-venv
pipx install --include-deps ansible
pipx ensurepath
```

Change hosts.ini to match the IP of the VM/server
```
node1 ansible_host=10.201.1.107 ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa ansible_sudo_pass=ubuntu
```

Change vars/main.yaml to use the `ens3` iface and IP address above

Test that it works
```
make aether-pingall
```



# Aether-in-a-Box

```bash
sudo snap install code --classic &
sudo apt install -y make xterm

git clone "https://gerrit.opencord.org/aether-in-a-box"
cd ~/aether-in-a-box

cat << EOF | patch -p1
diff --git a/sd-core-5g-values.yaml b/sd-core-5g-values.yaml
index d4e145c..de38a69 100644
--- a/sd-core-5g-values.yaml
+++ b/sd-core-5g-values.yaml
@@ -233,6 +233,8 @@ omec-user-plane:
     enabled: false
   images:
     repository: "registry.opennetworking.org/docker.io/"
+    tags:
+      tools: busybox:stable
     # uncomment below section to add update bess image tag
     #tags:
     #  bess: <bess image tag>
EOF

CHARTS=latest make roc-5g-models
CHARTS=latest make 5g-test

cd ~
git clone https://github.com/omec-project/amf.git

cd amf
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo make docker-build
```

As admin, to disable port security
```
port set --disable-port-security --no-security-group 114a5bec-6a6a-434f-a3e6-9ffe1f80f73a
```