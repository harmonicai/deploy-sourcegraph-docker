#!/usr/bin/env bash
set -e
source ./replicas.sh

# Description: LSIF HTTP server for code intelligence.
#
# Disk: 200GB / persistent SSD
# Network: 100mbps
# Liveness probe: n/a
# Ports exposed to other Sourcegraph services: 3186/TCP (server) 3187/TCP (worker)
# Ports exposed to the public internet: none
#
docker run --detach \
    --name=lsif-server \
    --network=sourcegraph \
    --restart=always \
    --cpus=2 \
    --memory=2g \
    -e GOMAXPROCS=2 \
    -e LSIF_STORAGE_ROOT=/lsif-storage \
    -e SRC_FRONTEND_INTERNAL=sourcegraph-frontend-internal:3090 \
    -v ~/sourcegraph-docker/lsif-server-disk:/lsif-storage \
    sourcegraph/lsif-server:3.10.1@sha256:113ef2a22e5b993476ce2d60899de3edd61df35cc61cc4d1528d2d1c94206a89

echo "Deployed lsif-server service"
