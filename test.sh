python tools/dist_test.py \
configs/nusc/voxelnet/nusc_centerpoint_voxelnet_0075voxel_dcn_flip.py \
--work_dir work_dirs/centerpoint_voxel_1440_dcn_flip_testset  \
--checkpoint work_dirs/nusc_0075_dcn_flip_track/voxelnet_converted.pth  \
--testset \
--speed_test 
