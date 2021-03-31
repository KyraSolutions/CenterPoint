#!/bin/bash

IMGNAME="centerpoint:latest"

function usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "    -c,--clean 		        Clean build."
    echo "                          Default:$CLEAN"
    echo "    -h,--help             Display the usage and exit."
}

OPTS=`getopt --options c:h \
         --long clean,help \
         --name "$0" -- "$@"`
eval set -- "$OPTS"

while true; do
  case $1 in
    -c|--clean)
	  echo "Building docker image from scratch."
      docker build \
    --build-arg USER_ID=$(id -u) \
    --build-arg GROUP_ID=$(id -g) \
	  --no-cache \
	  --rm \
	  -t $IMGNAME .
      exit 0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    --)
	if [ ! -z $2 ];
      then
        echo "Invalid parameter: $2"
        exit 1
      fi
      break
      ;;
    *)
      echo "Invalid option"
      exit 1
      ;;
  esac
done

echo "Building docker image from cache."
docker build \
--build-arg USER_ID=$(id -u) \
--build-arg GROUP_ID=$(id -g) \
--rm \
-t $IMGNAME .


