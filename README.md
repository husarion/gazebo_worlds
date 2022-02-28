# gazebo_worlds
Custom made gazebo worlds

### Run Husarion Office world with Rosbot init in gazebo simulation.
Depending on your hardware configuration your docker-compose.yaml file may differ. For Intel and AMD users you will need following docker-compose.yaml configuration:
```
version: "3.9"

services:
  husarion-office:
    image: husarion_world
    environment:
      - "DISPLAY"
      - "QT_X11_NO_MITSHM=1"
    volumes:
      - /tmp/.X11-unix:/tmp/.X11-unix:rw
    command: ros2 launch husarion_office_gz husarion_office_world.launch.py
```
Nvidia users have to install nvidia-docker2. Installation steps can be found here. With nvidia-docker2 installed following docker-compose.yaml will be needed:
```
version: "3.9"

services:
  husarion-office:
    image: husarion_world
    runtime: nvidia
    environment:
        - "DISPLAY"
        - "QT_X11_NO_MITSHM=1"
        - NVIDIA_VISIBLE_DEVICES=all
        - NVIDIA_DRIVER_CAPABILITIES=compute,utility,display
    volumes:
        - /tmp/.X11-unix:/tmp/.X11-unix:rw
    command: ros2 launch husarion_office_gz husarion_office_world.launch.py
```

### Examples

In order to run simulation inside docker you have to give it access to you X11 server and start docker-compose.
```
cd examples/no_nvidia_compose_yaml
xhost local:docker
docker-compose up
```
For users with Nvidia GPU:

```
cd examples/nvidia_compose_yaml
xhost local:docker
docker-compose up
```