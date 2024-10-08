#!/usr/bin/env bash

# This script creates a fleet of Kubernetes clusters using kind.

# Copyright 2024 The Flux authors. All rights reserved.
# SPDX-License-Identifier: Apache-2.0

# Prerequisites
# - docker v25.0
# - kind v0.22
# - kubectl v1.29

set -o errexit
set -o pipefail

export KIND_EXPERIMENTAL_PROVIDER=podman
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

repo_root=$(git rev-parse --show-toplevel)
mkdir -p "${repo_root}/bin"

CLUSTER_VERSION="${CLUSTER_VERSION:=v1.29.2}"

CLUSTER_HUB="flux-hub"
echo "INFO - Creating cluster ${CLUSTER_HUB}"

kind create cluster --name "${CLUSTER_HUB}" \
--image "kindest/node:${CLUSTER_VERSION}" \
--wait 5m

CLUSTER_STAGING="flux-tenant-12345"
echo "INFO - Creating cluster ${CLUSTER_STAGING}"

kind create cluster --name "${CLUSTER_STAGING}" \
--image "kindest/node:${CLUSTER_VERSION}" \
--wait 5m

CLUSTER_PRODUCTION="flux-internal-las1"
echo "INFO - Creating cluster ${CLUSTER_PRODUCTION}"

kind create cluster --name "${CLUSTER_PRODUCTION}" \
--image "kindest/node:${CLUSTER_VERSION}" \
--wait 5m

echo "INFO - Creating kubeconfig secrets in the hub cluster"

kubectl config use-context "kind-${CLUSTER_HUB}"

kind get kubeconfig --internal --name ${CLUSTER_STAGING} > "${repo_root}/bin/tenant-12345.kubeconfig"
kubectl --context "kind-${CLUSTER_HUB}" create ns tenant-12345
kubectl --context "kind-${CLUSTER_HUB}" create secret generic -n tenant-12345 cluster-kubeconfig \
--from-file=value="${repo_root}/bin/tenant-12345.kubeconfig"

kind get kubeconfig --internal --name ${CLUSTER_PRODUCTION} > "${repo_root}/bin/internal-las1.kubeconfig"
kubectl --context "kind-${CLUSTER_HUB}" create ns internal-las1
kubectl --context "kind-${CLUSTER_HUB}" create secret generic -n internal-las1 cluster-kubeconfig \
--from-file=value="${repo_root}/bin/internal-las1.kubeconfig"

echo "INFO - Clusters created successfully"

podman cp ${SCRIPT_DIR}/nscacert.pem "${CLUSTER_HUB}-control-plane:/etc/ssl/certs/nscacert.crt"; \
podman exec ${CLUSTER_HUB}-control-plane /bin/bash -c "systemctl restart containerd"; \

podman cp ${SCRIPT_DIR}/nscacert.pem "${CLUSTER_PRODUCTION}-control-plane:/etc/ssl/certs/nscacert.crt"; \
podman exec ${CLUSTER_PRODUCTION}-control-plane /bin/bash -c "systemctl restart containerd"; \

podman cp ${SCRIPT_DIR}/nscacert.pem "${CLUSTER_STAGING}-control-plane:/etc/ssl/certs/nscacert.crt"; \
podman exec ${CLUSTER_STAGING}-control-plane /bin/bash -c "systemctl restart containerd"; \

echo "INFO - Added netskope cert successfully"
