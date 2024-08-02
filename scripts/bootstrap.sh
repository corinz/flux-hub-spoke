#!/bin/sh
set xou -pipefail

flux bootstrap github \
    --context=kind-flux-hub \
    --owner=corinz \
    --repository=flux-hub-spoke \
    --branch=main \
    --personal \
    --path=hub
