## Commands
alias srt=`rospack find robotrainer_bringup`/scripts/robotrainer_on_login.bash
alias start_transport=`rospack find robotrainer_bringup`/scripts/robotrainer_transport.bash

alias rt2_mapping="roslaunch robotrainer_bringup rt2_mapping.launch"
alias rt2_adaptive="roslaunch robotrainer_bringup rt2_adaptive.launch"
alias rt2_camera="roslaunch robotrainer_bringup rt2_camera_tracking.launch"

## Kinematics
alias kin_rt2_11='rosservice call /robotrainer_hw/set_state "{angular_key: 1, linear_key: 1}"'
alias kin_rt2_14='rosservice call /robotrainer_hw/set_state "{angular_key: 1, linear_key: 4}"'
alias kin_rt2_51='rosservice call /robotrainer_hw/set_state "{angular_key: 5, linear_key: 1}"'
alias kin_rt2_54='rosservice call /robotrainer_hw/set_state "{angular_key: 5, linear_key: 4}"'

