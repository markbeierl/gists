# Manual Seeding on 1.3/beta

All the charms:

* sdcore-amf-k8s
* sdcore-ausf-k8s
* sdcore-gnbsim-k8s
* sdcore-nms-k8s
* sdcore-nrf-k8s
* sdcore-nssf-k8s
* sdcore-pcf-k8s
* sdcore-router-k8s
* sdcore-smf-k8s
* sdcore-udm-k8s
* sdcore-udr-k8s
* sdcore-upf-k8s
* sdcore-webui-k8s

```bash
for charm in amf ausf gnbsim nms nrf nssf pcf router smf udm udr upf webui
do
    charmcraft status sdcore-${charm}-k8s --format json > ${charm}.json
    beta_revision=$(cat ${charm}.json | jq -r .[0].mappings[0].releases[2].revision)

    index=0
    resource_list=""
    for resource in $(cat ${charm}.json | jq -r .[0].mappings[0].releases[2].resources | grep name | cut -d\" -f4)
    do
        resource_revision=$(cat ${charm}.json | jq -r .[0].mappings[0].releases[2].resources[0] | grep revision | cut -d: -f2 | tr -d ' ')
        resource_list="${resource_list} --resource ${resource}:${resource_revision}"
    done

    echo charmcraft release sdcore-${charm}-k8s --revision=${beta_revision} ${resource_list} --channel=1.3/beta
done
```