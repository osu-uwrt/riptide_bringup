#!/bin/bash

# Write user's IP to params.yaml
USER_IP=`hostname -I | cut -f1 -d' '`
echo "ROS_IP: $USER_IP" > ../riptide_gazebo/config/params.yaml
rosparam set ROS_IP $USER_IP

# TODO: Add automatic assignment of IP to ROSConnectionPrefab
# LINE_NUM=`grep -n "m_RosIPAddress" /home/$USER/Unity/riptide_simulator/Assets/Resources/ROSConnectionPrefab.prefab`
# sed -i "s/.*m_RosIPAddress.*/m_RosIPAddress ${LINE_NUM}./" /home/$USER/Unity/riptide_simulator/Assets/Resources/ROSConnectionPrefab.prefab

# This must be updated along side the editor version used for the simulator.
unity_version="2020.3.17f1"

# Ensure that your editors are installed at this directory!
/home/$USER/Unity/Hub/Editor/$unity_version/Editor/Unity -projectPath "/home/$USER/Unity/riptide_simulator"