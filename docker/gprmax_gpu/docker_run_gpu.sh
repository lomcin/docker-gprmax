#!/bin/bash

IMAGE_NAME=gprmax/gprmaxgpu
CONTAINER_LABEL=gprmax_container

ML_MODELS_PATH=$(realpath $LWS/../ml-models)
WORKDIR=$LWS

mkdir -p $(pwd)/container/home/$USER

T_FLAG=""
if [ -t 1 ] ; then echo "Interactive"; T_FLAG="t"; else echo "Not interactive. (No TTY input device found)"; fi

nvidia-docker run -i$T_FLAG --rm --runtime=nvidia -e NVIDIA_VISIBLE_DEVICES=all \
       --user $(id -u):$(id -g) \
       --env="DISPLAY" \
       --env="QT_X11_NO_MITSHM=1" \
       --network="host" \
       --workdir="$WORKDIR" \
       --ipc="host" \
       --privileged \
       --oom-kill-disable \
       --volume="/dev:/dev" \
       --volume="$WORKDIR:$WORKDIR:rw" \
       --volume="$ML_MODELS_PATH:$ML_MODELS_PATH:rw" \
       --name="$CONTAINER_LABEL" \
       --volume="$(pwd)/container/home/$USER:/home/$USER:rw" \
       --volume="/etc/group:/etc/group:ro" \
       --volume="/etc/passwd:/etc/passwd:ro" \
       --volume="/etc/shadow:/etc/shadow:ro" \
       --volume="/etc/sudoers.d:/etc/sudoers.d:ro" \
       --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
       --volume="/dev/shm:/dev/shm:rw" \
       $IMAGE_NAME ${@:1}

exit $?
