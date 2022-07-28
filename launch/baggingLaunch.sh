#acceptable choices vision, sensors, mapping, diagnostics, all, test
#./baggingLaunch.sh [bagging choice]

#To run must install
    #ros-galactic-ros2bag
    #ros-galactic-rosbag2-storage-default-plugins
#And maybe install - if it works
    #ros-galactic-rosbag2-converter-default-plugins

#You can ignore the firmware error - probably
#All bags record voltage!

echo "Starting Ros2 Bagging Node!!"
date=$(date +'%m_%d_%Y__%H_%M_%S')


case $1 in 
    #bag vision
    "vision") 
        echo "Bagging Vision!"
        saveName="vision__$date"

        #launch the vision bagging
        ros2 bag record --include-hidden-topics -o $saveName \
            /rosout_agg \
            stereo/left/image_raw/compressed \
            stereo/left/camera_info \
            stereo/right/image_raw/compressed \
            stereo/right/camera_info \
            /tempest/state/electrical
        ;;

    #bag sensors
    "sensors")
        echo "Bagging Sensors!"
        saveName="sensors__$date"

        #launch sensor bagging
        ros2 bag record --include-hidden-topics -o $saveName \
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
            /tf \
            /tempest/state/electrical

        ;;   

    #bag mapping
    "mapping")
        echo "Bagging Mapping"
        saveName="mapping__$date"

        #launch mapping bagging
        ros2 bag record --include-hidden-topics -o $saveName \
            /rosout_agg \
            mapping/cutie \
            mapping/tommy \
            mapping/gman \
            mapping/bootlegger \
            mapping/badge \
            mapping/gate \
            dope/detected_objects \
            /tf \
            /tempest/state/electrical

        ;;

    #bagging diagnostics
    "diagnostics")
        echo "Bagging Diagnostics"
        saveName="diagnostics__$date"
        
        #launch diagnostics bagging
        ros2 bag record --include-hidden-topics -o $saveName \
            /rosout_agg \
            /diagnostics \
            /diagnostics_agg \
            /diagnostics_toplevel_state \
            /tempest/state/electrical

        ;;

    #bag all topics - not recommended
    "all")
        echo "Bagging All Topics - Prepare your hardrive/SSD!!!!"
        saveName="all__$date"

        #launch all bagging
        ros2 bag record --include-hidden-topics -o $saveName -a
    ;;

    #doesn't bag anything - just for testing ;)
    "test")
        echo "Testing Mode!"
        date=$(date +'%m_%d_%Y__%H_%M_%S')
        echo "test$date"
    ;;


esac
