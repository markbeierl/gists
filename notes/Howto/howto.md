# Swap AMF and Traefik IPs

Symptom:

You can see the AMF and traefik with the wrong IPs on the control plane cluster

`kubectl get service -n control-plane | grep LoadBalancer`
```
traefik                              LoadBalancer   10.152.183.159   10.201.0.52   80:32106/TCP,443:31742/TCP              89s
amf-external                         LoadBalancer   10.152.183.205   10.201.0.53   38412:30488/SCTP                        99s
```

Fix:

On Juju controller:
```
juju scale-application amf 0
juju scale-application traefik 0
```

On control-plane vm:
```
kubectl delete service -n control-plane traefik
```

Scale it back up on juju controller, giving the AMF time to come back up:
```
juju scale-application amf 1
sleep 30
juju scale-application traefik 1
```

# CPU Set for DPDK

```yaml
    meson-parameters:
      - -Dmachine=sandybridge
```

# Import rock into microk8s

```
sudo microk8s ctr image import --base-name docker.io/mbeierl/sdcore-upf-bess ~/git/GitHub/canonical/sdcore-upf-bess-rock/sdcore-upf-bess_1.3_amd64.rock
```