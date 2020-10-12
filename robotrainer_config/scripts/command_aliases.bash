## Commands
alias srt=`rospack find robotrainer_bringup`/scripts/robotrainer_on_login.bash
alias start_transport=`rospack find robotrainer_bringup`/scripts/robotrainer_transport.bash

alias rt2_mapping="roslaunch robotrainer_bringup rt2_mapping.launch"
alias rt2_adaptive="roslaunch robotrainer_bringup rt2_adaptive.launch"
alias rt2_camera="roslaunch robotrainer_bringup rt2_camera_tracking.launch"
alias rt2_performance="roslaunch robotrainer_bringup rt2_user_performance.launch"
alias user_study_manager="roslaunch robotrainer_bringup rt2_user_study_manager.launch"

## Kinematics
alias kin_rt2_11='rosservice call /robotrainer_hw/set_state "{angular_key: 1, linear_key: 1}"'
alias kin_rt2_14='rosservice call /robotrainer_hw/set_state "{angular_key: 1, linear_key: 4}"'
alias kin_rt2_51='rosservice call /robotrainer_hw/set_state "{angular_key: 5, linear_key: 1}"'
alias kin_rt2_54='rosservice call /robotrainer_hw/set_state "{angular_key: 5, linear_key: 4}"'

# Recording for Eval
# alias eval_record_base="bash `rospack find robotrainer_config`/scripts/record_base_values.bash ~/RT2_Data/RoSy_PreEval/"
# alias eval_record_cam="bash `rospack find robotrainer_config`/scripts/record_camera_values.bash ~/RT2_ta/RoSy_PreEval/Cams"

# Recording for Eval with observers
alias eval_record_base_bg="bash `rospack find robotrainer_config`/scripts/record_bag_in_background.bash .RoboTrainer/study_record_base.status `rospack find robotrainer_config`/scripts/record_base_values.bash ~/RT2_Data/RoSy_PreEval/"

alias eval_record_cam_bg="bash `rospack find robotrainer_config`/scripts/record_bag_in_background.bash .RoboTrainer/study_record_cam.status `rospack find robotrainer_config`/scripts/record_camera_values.bash ~/RT2_Data/RoSy_PreEval/Cams"

