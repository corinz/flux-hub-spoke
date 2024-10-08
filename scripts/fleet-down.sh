#!/usr/bin/env bash

# This script tears down the fleet of Kubernetes clusters.

# Copyright 2024 The Flux authors. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

set -o errexit
set -o pipefail

export KIND_EXPERIMENTAL_PROVIDER=podman

CLUSTER_HUB="flux-hub"
echo "INFO - Deleting cluster ${CLUSTER_HUB}"

kind delete cluster --name "${CLUSTER_HUB}"

CLUSTER_STAGING="flux-tenant-12345"
echo "INFO - Deleting cluster ${CLUSTER_STAGING}"

kind delete cluster --name "${CLUSTER_STAGING}"

CLUSTER_PRODUCTION="flux-internal-las1"
echo "INFO - Deleting cluster ${CLUSTER_PRODUCTION}"

kind delete cluster --name "${CLUSTER_PRODUCTION}"

echo "INFO - Clusters deleted successfully"
