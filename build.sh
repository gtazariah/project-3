#!/bin/bash

set -e

DOCKERHUB_USERNAME="azariahgt"

ENVIRONMENT=$1

IMAGE_TAG=${2: -latest}

if [ "$ENVIRONMENT" != "dev" ] && [ "$ENVIRONMENT" != "prod" ]; then
	echo "Invalid Environment"
	exit 1
fi

IMAGE_NAME="${DOCKERHUB_USERNAME}/${ENVIRONMENT}"

FULL_IMAGE_NAME="${IMAGE_NAME}:${IMAGE_TAG}"

docker build \
	-t "${FULL_IMAGE_NAME}" \
	.

docker push "${FULL_IMAGE_NAME}"


