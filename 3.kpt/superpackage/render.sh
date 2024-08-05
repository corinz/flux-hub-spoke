#!/bin/sh
KPT_FN_RUNTIME=podman kpt fn render -o stdout > ../../4.deploy/production/rendered.yaml
