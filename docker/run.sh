#!/bin/bash

VOLUMES="--volume=/tmp/.X11-unix:/tmp/.X11-unix
		 --volume=/etc/passwd:/etc/passwd 
		 --volume=${PWD}/..:/Workspace/projects/CenterPoint"

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
--user "$(id -u):$(id -g)" \
--runtime=nvidia \
--ipc=host \
--workdir="/Workspace/projects/CenterPoint" \
--entrypoint="/bin/bash" \
centerpoint:latest
