#!/bin/bash

konsole -e "roslaunch robotrainer_bringup sr3_on_login.launch" &!

konsole --new-tab -e "rviz --fullscreen -d `rospack find robotrainer_bringup`/configs/rt2_display_fullscreen.rviz" &!

