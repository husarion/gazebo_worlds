FROM ros:foxy-ros-base

# Use bash instead of sh
SHELL ["/bin/bash", "-c"]

RUN apt update \
    && apt install -y ros-foxy-gazebo-ros-pkgs ros-foxy-nav* ros-foxy-rviz2

WORKDIR /

# Create and initialise ROS workspace
RUN mkdir gazebo_worlds \
    && cd gazebo_worlds \
    && git clone https://github.com/husarion/gazebo_worlds.git src \
    && git clone -b foxy https://github.com/husarion/rosbot_description.git src/rosbot_description

COPY ./rosbot_spawn.launch.py /gazebo_worlds/src/rosbot_description/launch/rosbot_spawn.launch.py

RUN source /opt/ros/foxy/setup.bash \
    && colcon build 

COPY ./ros_entrypoint.sh /