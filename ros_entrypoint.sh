#!/bin/bash

set -e

source /opt/ros/foxy/setup.bash
source /gazebo_worlds/install/setup.bash
source /usr/share/gazebo-11/setup.bash
export GAZEBO_MODEL_PATH="/usr/share/gazebo-11/../../share/gazebo-11/models:/gazebo_worlds/install/husarion_office_gz/share/husarion_office_gz/worlds/models"

exec "$@"