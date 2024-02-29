# Setup

In the project's .vscode directory, add the launch.json and settings.json as follows.  Also need to `pip install pytest-cov`

```bash
. .tox/unit/bin/activate
pip install pytest-cov
```

Copy the .env file into the project's root directory.

`launch.json`: this is only needed for debugging a unit test without having the coverage interfere. Without this, breakpoints will not work.
```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Python: Debug Tests",
            "type": "python",
            "request": "launch",
            "program": "${file}",
            "purpose": ["debug-test"],
            "console": "integratedTerminal",
            "env": {
                "PYTEST_ADDOPTS": "--no-cov"
            },
            "justMyCode": false
        }
    ]
}
```
`settings.json`
```json
{
    "cmake.configureOnOpen": false,
    "python.testing.unittestEnabled": false,
    "python.testing.pytestEnabled": true,
    "python.testing.pytestArgs": [
        "-v",
        "--cov=src/",
        "--cov-report=xml",
        "tests/"
    ]
}
```

After this, you can install `coverage-gutters` and then start watching for changes.