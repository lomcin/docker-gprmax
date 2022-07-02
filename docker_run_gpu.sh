#!/bin/bash

export LWS=$(pwd)
VERSION=cpu

if [ -z $1 ]
then
	echo "Using default version: '$VERSION'."
else
	VERSION=$1
	echo "Using '$VERSION'."
fi
VERSION_DIR=$LWS/docker/gprmax_$VERSION

cd $VERSION_DIR

bash ./docker_run_gpu.sh ${@:2}

DOCKER_EXIT_CODE=$?

cd $LWS

exit $DOCKER_EXIT_CODE

