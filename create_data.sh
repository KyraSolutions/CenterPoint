# Note: trainval and test sets are huge. It doesn't work (i.e. process is Killed) 
# when chrome is open but loads fine when I close chrome. 
# Took ~30s to load nuscenes table for trainval

# Change these every time you have a new dataset
DATA_FOLDER="/home/user/workspace/data/nuScenes/full/test"
VERSION="v1.0-test" # v1.0-mini, "v1.0-trainval", "v1.0-test"

# No need to change these
CENTERPOINT="/home/user/workspace/CenterPoint"
SYMLINK_DATA="$CENTERPOINT/data/nuScenes"
ln -s $DATA_FOLDER $SYMLINK_DATA

python $CENTERPOINT/tools/create_data.py nuscenes_data_prep \
--root_path=$SYMLINK_DATA \
--version="$VERSION" \
--nsweeps=10