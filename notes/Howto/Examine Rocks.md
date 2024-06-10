# Examining Rocks

There is probably a better way to do this, but for now, here is what I did.

## Install docker in VM

VM:

```bash
sudo snap install docker
sudo addgroup --system docker
sudo adduser $USER docker
newgrp docker
sudo snap disable docker
sudo snap enable docker
exit
```

## Using Pebble

```bash
docker run -it ghcr.io/canonical/sdcore-upf-bess:1.3 ls /
docker run -it ghcr.io/canonical/sdcore-upf-bess:1.3 exec /bin/bash
```

## Using Docker to Examine Rock

`rockcraft pack`

Then, on target machine

```
 sudo skopeo --insecure-policy copy oci-archive:sdcore-amf_1.4.2_amd64.rock docker-daemon:test-amf:9
```