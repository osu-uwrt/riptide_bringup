#!/bin/bash

# Write user's IP to params.yaml
USER_IP=`hostname -I | cut -f1 -d' '`
cd /home/$USER/osu-uwrt/riptide_software/src/ROS-TCP-Endpoint/config/
echo "ROS_IP: $USER_IP" > params.yaml
rosparam set ROS_IP $USER_IP

# This must be updated along side the editor version used for the simulator.
unity_version="2020.3.17f1"

# Ensure that your editors are installed at this directory!
/home/$USER/Unity/Hub/Editor/$unity_version/Editor/Unity -projectPath "/home/$USER/Unity/riptide_simulator"