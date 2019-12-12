#!/bin/bash -x

set -e

rm -rf layer
docker build -t libvips-golang-lambda-layer .
CONTAINER=$(docker run -d libvips-golang-lambda-layer false)
docker cp $CONTAINER:/build/share layer
docker rm $CONTAINER
touch layer/.slsignore
cat > layer/.slsignore << EOF
**/*.a
**/*.la
share/**
include/**
bin/**
EOF