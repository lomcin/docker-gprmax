#!/bin/bash

IMAGE_NAME=maggi10/gprmax:gpu
IMAGE_FILE=gprMax_gpu.dockerfile

echo $(pwd)
docker build -f $IMAGE_FILE -t $IMAGE_NAME $(pwd)
