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

alias eval_record_base="bash `rospack find robotrainer_config`/scripts/record_base_values.bash ~/RT2_Data/RoSy_PreEval/"
alias eval_record_cam="bash `rospack find robotrainer_config`/scripts/record_camera_values.bash ~/RT2_ta/RoSy_PreEval/Cams"

