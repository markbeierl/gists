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

```bash
for charm in amf ausf gnbsim nms nrf nssf pcf router smf udm udr upf webui
do
    echo ============================================ sdcore-${charm}-k8s-operator
    git -C sdcore-${charm}-k8s-operator checkout main
    git -C sdcore-${charm}-k8s-operator pull
done
```

```bash
for charm in amf ausf gnbsim nms nrf nssf pcf router smf udm udr upf webui
do
    echo ============================================ sdcore-${charm}-k8s-operator
    git -C sdcore-${charm}-k8s-operator checkout main
    git -C sdcore-${charm}-k8s-operator pull
    git -C sdcore-${charm}-k8s-operator checkout -b TELCO-948_tracks-for-charms
done
```

```bash
for charm in amf ausf gnbsim nms nrf nssf pcf router smf udm udr upf webui
do
    echo ============================================ sdcore-${charm}-k8s-operator
    git -C sdcore-${charm}-k8s-operator commit -S -am "feat: TELCO-948 Use track for charm publication

Adds a new variable for what track to use when publishing and promoting
charms.
"
done
```

```bash
for charm in amf ausf gnbsim nms nrf nssf pcf router smf udm udr upf webui
do
    echo ============================================ sdcore-${charm}-k8s-operator
    git -C sdcore-${charm}-k8s-operator push --set-upstream origin TELCO-948_tracks-for-charms
done
```

For main.yaml:
      track-name: 1.3

for charm in ausf gnbsim nms nrf nssf pcf router smf udm udr upf webui
do
    echo cp -v sdcore-amf-k8s-operator/.github/workflows/promote.yaml sdcore-${charm}-k8s-operator/.github/workflows/promote.yaml
done


==================================================================================================================================
# Description

Adds a new variable for what track to use when publishing and publishing charms.

Depends on: https://github.com/canonical/sdcore-github-workflows/pull/24

# Checklist:

- [X] My code follows the [style guidelines](/CONTRIBUTING.md) of this project
- [X] I have performed a self-review of my own code
- N/A I have made corresponding changes to the documentation
- N/A I have added tests that validate the behaviour of the software
- N/A I validated that new and existing unit tests pass locally with my changes
- [X] Any dependent changes have been merged and published in downstream modules
- N/A I have bumped the version of the library

==================================================================================================================================

We would like to switch the default track from latest to 1.3 and will no longer be publishing to latest.

Please swtich the default track to 1.3 for the following charms:

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

And for the following bundles

* sdcore-k8s
* sdcore-control-plane-k8s
* sdcore-user-plane-k8s

Thanks!