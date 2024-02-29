# Setup Bess

Enter the UPF pod, then

```bash
export CONF_FILE=/etc/bess/conf/upf.json
/opt/bess/bessctl/bessctl http 0.0.0.0
```

On laptop, add route to the pod

```bash
sshuttle -vr user-plane.mgmt 10.1.36.0/24
```