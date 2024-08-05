# superpackage

## Description
sample description

## Usage

### Fetch the package
`kpt pkg get REPO_URI[.git]/PKG_PATH[@VERSION] superpackage`
Details: https://kpt.dev/reference/cli/pkg/get/

### View package content
`kpt pkg tree superpackage`
Details: https://kpt.dev/reference/cli/pkg/tree/

### Apply the package
```
kpt live init superpackage
kpt live apply superpackage --reconcile-timeout=2m --output=table
```
Details: https://kpt.dev/reference/cli/live/
