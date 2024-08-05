.ONESHELL:
.SHELLFLAGS += -e

.PHONY: validate
validate: # Validate the Flux manifests
	scripts/validate.sh

.PHONY: fleet-up
fleet-up: # Start local Kind clusters (flux-hub, flux-staging and flux-production)
	scripts/fleet-up.sh

.PHONY: fleet-down
fleet-down: # Teardown the Kind clusters
	scripts/fleet-down.sh

.PHONY: bootstrap
bootstrap:
	scripts/bootstrap.sh
