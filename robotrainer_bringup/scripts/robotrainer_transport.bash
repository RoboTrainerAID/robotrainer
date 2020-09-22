#!/bin/bash

## Update to default kinematics
rosservice call /robotrainer_hw/set_state "{angular_key: 1, linear_key: 1, without_controller_updates: True}"

konsole -e "roslaunch robotrainer_bringup sr3_on_login.launch" &!

konsole -e "roslaunch robotrainer_bringup sr3.launch" &!

# konsole --new-tab -e "rviz --fullscreen -d `rospack find robotrainer_bringup`/configs/rt2_display_fullscreen.rviz" &!

