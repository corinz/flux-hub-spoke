# istio

## Description
sample description

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] istio`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree istio`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init istio
kpt live apply istio --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
