## Philosophy
- This is a CD repo.
- It is designed to do CD.
- Though it can do _some_ templating, it is not designed to handle the complexity of templating a release for a given region, cluster, and/or tenant.

## Instead...
### Invest in existing helm charts

- too many cooks in the kitchen?: package and version with oci repo, GHA's
- unpredictable changes?: generate manifests on commit
- buggy?: kubeconform to check api against api spec's
- error prone?: write unit tests using helm unit test plugin
- complex?: reduce values into common values e.g. values.yaml + internal-cluster.yaml + us-east-01.yaml
- drift?: use flux helm controller to detect/correct drift
