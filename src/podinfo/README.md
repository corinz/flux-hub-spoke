# podinfo

## Description
sample description

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] podinfo`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree podinfo`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init podinfo
kpt live apply podinfo --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
