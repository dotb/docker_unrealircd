#!/usr/bin/bash

UNREAL_VERSION=$1

docker tag dotb/unrealircd:$UNREAL_VERSION dotb/unrealircd:latest
docker push dotb/unrealircd:$UNREAL_VERSION
docker push dotb/unrealircd:latest
