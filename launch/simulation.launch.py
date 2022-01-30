import launch
from launch_ros.actions import Node
from launch.launch_description_sources import AnyLaunchDescriptionSource
from launch.actions import IncludeLaunchDescription
from ament_index_python.packages import get_package_share_directory
from launch.launch_description import LaunchDescription
from launch.actions import DeclareLaunchArgument, GroupAction
from launch_ros.actions import PushRosNamespace
from launch.substitutions import LaunchConfiguration as LC
import os

# all of the launch files to start
launch_files = [
    os.path.join(
        get_package_share_directory('riptide_hardware2'),
        'launch',
        'hardware.launch.py'),
    os.path.join(
        get_package_share_directory('riptide_hardware2'),
        'launch',
        'diagnostics.launch.py'),
    os.path.join(
        get_package_share_directory('riptide_controllers2'),
        'launch',
        'controller.launch.py'),
    os.path.join(
        get_package_share_directory('riptide_teleop2'),
        'launch',
        'ps3_teleop.launch.py'),
    os.path.join(
        get_package_share_directory('riptide_navigation2'),
        'launch',
        'navigation.launch.py'),
    os.path.join(
        get_package_share_directory('riptide_navigation2'),
        'launch',
        'mapping.launch.py'),
    os.path.join(
        get_package_share_directory('riptide_autonomy2'),
        'launch',
        'actions.launch.py')
]

def generate_launch_description():
    # read the parameter for robot name
    robot_name = LC('robot')

    # setup a list to collect launch descriptions
    descrips = []

    # setup a namespace to put everything in
    descrips.append(PushRosNamespace(robot_name))

    # iterate the list of launch files we were given to start
    for launch_file in launch_files:
        descrips.append(
            IncludeLaunchDescription(
                AnyLaunchDescriptionSource(launch_file),
                launch_arguments=[
                    ('namespace', robot_name),
                    ('robot', robot_name),
                ]
            )
        )

    # create the launch description 
    return LaunchDescription([
        DeclareLaunchArgument('robot', default_value='tempest', description='name of the robot to spawn'),
        GroupAction(descrips)
    ])