#!/usr/bin/env bash

BASEDIR=$(dirname "$0")
PROJECT_DIR="$(realpath "${BASEDIR}")"

cd $PROJECT_DIR || exit

IMAGE_NAME="h5-serve"

GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
GIT_COMMIT=$(git rev-parse --short HEAD)
IMAGE_TAG="caddy-${GIT_BRANCH}-${GIT_COMMIT}"

echo "Will build image: $IMAGE_NAME:$IMAGE_TAG"

# rm docker containers and images if exists
CONTAINERS=$(docker ps -a -q -f name=$IMAGE_NAME)
if [ -n "$CONTAINERS" ]; then
    docker rm -f $CONTAINERS
fi
IMAGES=$(docker images -q $IMAGE_NAME)
if [ -n "$IMAGES" ]; then
    docker rmi -f $IMAGES
fi

# build image
docker build --progress=plain --no-cache -t $IMAGE_NAME:$IMAGE_TAG -f ./Dockerfile-caddy ./

# upload image
docker image tag $IMAGE_NAME:$IMAGE_TAG darklinden/$IMAGE_NAME:$IMAGE_TAG
docker push darklinden/$IMAGE_NAME:$IMAGE_TAG
docker image tag darklinden/$IMAGE_NAME:$IMAGE_TAG darklinden/$IMAGE_NAME:caddy
docker push darklinden/$IMAGE_NAME:caddy
docker image tag darklinden/$IMAGE_NAME:$IMAGE_TAG darklinden/$IMAGE_NAME:latest
docker push darklinden/$IMAGE_NAME:latest
