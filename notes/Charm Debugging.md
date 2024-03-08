# Charm Debugging

How I use vscode to debug my charms

## Env Setup

```bash
sudo snap install jhack
sudo snap connect jhack:dot-local-share-juju snapd
```

## Charm Setup

Either:

1. Update the requirements.txt of the charm to add debugpy, or
1. Log into the running charm and `python3 -m pip install --upgrade debugpy`

Then in the charm code, add
```python
        import debugpy
        debugpy.listen(5678)
        print("Waiting for debugger attach")
        debugpy.wait_for_client()
        debugpy.breakpoint()
```

```bash
jhack sync sdcore-upf-k8s/0
```

inotifywait -e modify,create,delete -r src && rsync -avt src pc7:sdcore-upf-operator

Set the IP address of the unit in .vscode/settings.json
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Remote Attach",
            "type": "python",
            "request": "attach",
            "connect": {
                "host": "10.1.36.217",
                "port": 5678
            },
            "pathMappings": [
                {
                    "localRoot": "${workspaceFolder}",
                    "remoteRoot": "."
                }
            ],
            "justMyCode": false
        }
    ]
}```