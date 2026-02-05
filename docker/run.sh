# rocker --network host --privileged --nvidia --x11 --user --name phoxi \
#     --env="USER" \
#     --env=RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
#     --volume "${HOME}/phoxi_ws:${HOME}/phoxi_ws" \
#     --volume /dev/shm \
#     --volume ${HOME}/.vscode:${HOME}/.vscode-server \
#     -- amadeuszsz/phoxi:humble
# rocker --network host --privileged --nvidia --x11 --user --name phoxi-mine \
#     --env="USER" \
#     --env=RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
#     --env=PHOXI_CONTROL_PATH=/opt/Photoneo/PhoXiControl-1.16.4 \
#     --env=LD_LIBRARY_PATH=/opt/Photoneo/PhoXiControl-1.16.4/API/lib:$LD_LIBRARY_PATH \
#     --volume /dev/shm \
#     --persist-image \
#     -- phoxi-mine bash

rocker --network host --privileged --nvidia --x11 --user --name phoxi-mine \
    --env="USER" \
    --env=RMW_IMPLEMENTATION=rmw_fastrtps_cpp \
    --env=PHOXI_CONTROL_PATH=/opt/Photoneo/PhoXiControl-1.16.4 \
    --env=LD_LIBRARY_PATH=/opt/Photoneo/PhoXiControl-1.16.4/API/lib:$LD_LIBRARY_PATH \
    --volume "$HOME/Documents/phoxi_camera_ros2/phoxi_camera_ros2/param/defaults.param.yaml:/phoxi_config.yaml" \
    --volume /dev/shm --persist-image \
    -- phoxi-mine bash -lc \"sudo service dbus start \&\& sudo /usr/sbin/avahi-daemon --daemonize \&\& ros2 launch phoxi_camera_ros2 phoxi_camera.launch.py phoxi_config_param_file:=/phoxi_config.yaml\"
# sudo service dbus start
# sudo /usr/sbin/avahi-daemon --daemonize
# sudo chown $USER:$USER ~/phoxi_ws/src/ ~/phoxi_ws