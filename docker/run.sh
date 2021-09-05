#!/bin/bash

VOLUMES="--volume=/tmp/.X11-unix:/tmp/.X11-unix
		 --volume=/etc/passwd:/etc/passwd 
		 --volume=${PWD}/..:/workspace/CenterPoint
		 --volume=/media/darren/Samsung_T5/datasets/nuScenes:/workspace/data/nuScenes"

xhost +local:docker

# env is for the pop up displays
# ipc=host is required to increased the shared memory size of the docker container for pytorch dataloader
docker run \
-it --rm \
$VOLUMES \
--env=NVIDIA_VISIBLE_DEVICES=all \
--env=NVIDIA_DRIVER_CAPABILITIES=all \
--env=DISPLAY \
--env=QT_X11_NO_MITSHM=1 \
--privileged \
--net=host \
--gpus=all \
--ipc=host \
--workdir="/workspace" \
centerpoint:ros-melodic-v2
