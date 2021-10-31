#!/bin/bash






# Automatic assignment of host IP for TCP connection
USER_IP=`hostname -I | cut -f1 -d' '`
echo "ROS_IP: $USER_IP" > ../riptide_gazebo/config/params.yaml # Write user's IP to params.yaml
rosparam set ROS_IP $USER_IP
sed -i "s/.*m_RosIPAddress.*/  m_RosIPAddress: ${USER_IP}/" /home/$USER/Unity/riptide_simulator/Assets/Resources/ROSConnectionPrefab.prefab

# This must be updated along side the editor version used for the simulator.
unity_version="2020.3.17f1"

# Ensure that your editors are installed at this directory!
/home/$USER/Unity/Hub/Editor/$unity_version/Editor/Unity -projectPath "/home/$USER/Unity/riptide_simulator"