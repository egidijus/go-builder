#!/bin/bash
set -ex
docker build -t go-builder -f Dockerfile . && \
docker run -it --rm -e DO_USER=$USER -e DO_UID=$UID \
    --rm \
    -v $(pwd)/gowork:/gowork \
    go-builder

