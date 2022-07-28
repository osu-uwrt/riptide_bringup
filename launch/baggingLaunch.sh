#acceptable choices vision, sensors, mapping, diagnostics
#./baggingLaunch.sh [bagging choice]

#To run must install
    #ros-galactic-ros2bag
    #ros-galactic-rosbag2-storage-default-plugins
#And maybe install - if it works
    #ros-galactic-rosbag2-converter-default-plugins

echo "Starting Ros2 Bagging Node!!"

case $1 in 
    #bag vision
    "vision") 
        echo "Bagging Vision!"
        #launch the vision bagging
        ros2 bag record -o \
            /rosout_agg \
            stereo/left/image_raw/compressed \
            stereo/left/camera_info \
            stereo/right/image_raw/compressed \
            stereo/right/camera_info \
        ;;

    #bag sensors
    "sensors")
        echo "Bagging Sensors!"
        ros2 bag record -o \
            /rosout_agg \
            dvl/twist \
            dvl_twist \
            dvl_sonar0 \
            dvl_sonar1 \
            dvl_sonar2 \
            vl_sonar3 \
            depth/raw \
            depth/pose \
            imu/data \
            /tf
        ;;   

    #bag mapping
    "mapping")
        echo "Bagging Mapping"
        ros2 bag record -o \
            /rosout_agg \
            mapping/cutie \
            mapping/tommy \
            mapping/gman \
            mapping/bootlegger \
            mapping/badge \
            mapping/gate \
            dope/detected_objects \
            /tf
        ;;

    #bagging diagnostics
    "diagnostics")
        echo "Bagging Diagnostics"
        ros2 bag record -o \
            /rosout_agg \
            /diagnostics \
            /diagnostics_agg \
            /diagnostics_toplevel_state \
        ;;
esac
