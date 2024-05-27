#!/usr/bin/bash

UNREAL_VERSION=$1

docker buildx build --no-cache --progress plain --build-arg UNREAL_VERSION=$UNREAL_VERSION -t dotb/unrealircd:$UNREAL_VERSION .

