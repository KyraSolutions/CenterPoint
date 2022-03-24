cmake_minimum_required(VERSION 3.0.2)
project(centerpoint_ros_msgs)

set(CMAKE_CXX_FLAGS "-std=c++11 ${CMAKE_CXX_FLAGS}")

find_package(catkin REQUIRED
  COMPONENTS
    actionlib_msgs
    geometry_msgs
    sensor_msgs
    jsk_recognition_msgs
    std_msgs
    message_generation
)

## Generate actions in the 'action' folder
add_action_files(
  FILES
  CloudCheckForObjects.action
)

## Generate added messages and services with any dependencies listed here
generate_messages(
  DEPENDENCIES
    actionlib_msgs
    geometry_msgs
    sensor_msgs
    jsk_recognition_msgs
    std_msgs
)

###################################
## catkin specific configuration ##
###################################
catkin_package(
  CATKIN_DEPENDS
    actionlib_msgs
    geometry_msgs
    sensor_msgs
    message_runtime
    std_msgs
)


###################################
## catkin specific configuration ##
###################################
catkin_package()

