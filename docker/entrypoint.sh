#!/bin/bash

echo "alias data = cd /home/user/workspace/data/nuScenes/full" >> ~/.bashrc
echo "alias centerpoint = cd /home/user/workspace/CenterPoint" >> ~/.bashrc

exec "$@"

/bin/bash
