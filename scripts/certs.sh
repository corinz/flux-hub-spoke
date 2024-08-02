#!/bin/sh

podman cp ./nscacert.pem "flux-hub-control-plane:/etc/ssl/certs/nscacert.crt"
podman exec flux-hub-control-plane /bin/bash -c "systemctl restart containerd"
