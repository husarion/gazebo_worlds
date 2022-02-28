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

RUN sed -i "82s#.*#            arguments=['-spawn_service_timeout', '60', '-entity', 'rosbot', '-x', '1.5', '-y', '-1.2', '-z', '0.03', '-file', rosbot_description_dir + '/models/rosbot.sdf']),#" /gazebo_worlds/src/rosbot_description/launch/rosbot_spawn.launch.py

WORKDIR /gazebo_worlds

RUN source /opt/ros/foxy/setup.bash \
    && colcon build \
    && echo 'source /opt/ros/foxy/setup.bash' >> ~/.bashrc \
    && echo 'source /gazebo_worlds/install/setup.bash' >> ~/.bashrc \
    && echo 'source /usr/share/gazebo-11/setup.bash' >> ~/.bashrc \
    && echo 'export GAZEBO_MODEL_PATH="/usr/share/gazebo-11/../../share/gazebo-11/models:/gazebo_worlds/install/husarion_office_gz/share/husarion_office_gz/worlds/models/"' >> ~/.bashrc

COPY ./ros_entrypoint.sh /