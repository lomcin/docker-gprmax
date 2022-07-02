#!/bin/bash

IMAGE_NAME=maggi10/gprmax
IMAGE_NAME2=maggi10/gprmax:cpu
IMAGE_FILE=gprMax_cpu.dockerfile

echo $(pwd)
docker build -f $IMAGE_FILE -t $IMAGE_NAME -t $IMAGE_NAME2 $(pwd)
