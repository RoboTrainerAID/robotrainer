robotrainer
==========================================

## ROS Distro Support

|         | Kinetic | Melodic |
|:-------:|:-------:|:-------:|
| Branch  | [`kinetic-devel`](https://gitlab.ipr.kit.edu/IIROB/robotrainer/tree/kinetic-devel) | 
| Status  | [![build status](https://gitlab.ipr.kit.edu/IIROB/robotrainer/badges/kinetic-devel/pipeline.svg)](https://gitlab.ipr.kit.edu/IIROB/robotrainer/commits/kinetic-devel) | |

## Status and ToDos

Status:
- When Starting the Adaptive Force Controller, the robot can be adapted using dynamic reconfigure.
- The corresponding parameters of the Yaml file are updated and should be ready-to-use for adaptive force feature
- passive behavior control now works as intended (can be switched on and off using dynamic reconfigure)

ToDos:
- Add testcase to determine center of rotation adaption
- Enable adaptive force by default using yaml parameters (instead of switching on/off in dynamic reconfigure)
- delete test parameters in dynamic reconfigure and port them to yaml parameters instead

## Dependencies and build problems


## Starting robotrainer with demo scenario

+ Open 4 terminal windows.
  - In terminal 1: load scenario to parameter server and setup filter chain
    ```
    rosparam load <robotrainer>/yamls/demo_scenario.yaml
    rosparam load <robotrainer>/yamls/modalities_chain.yaml
    ```
  - In terminal 2: start robot
    ```
    ssh modalities-sr2
    roslaunch sr2_bringup robotrainer.launch
    ```
  - In terminal 1: initialize robot (or use joystick `START+RB`)
    ```
    rosservice call /base/driver/init
    ```
  - In terminal 3: start RViz
    ```
    rviz
    ```
  - In terminal 4: start rqt
    ```
    rqt
    ```
+ You can now drive around with the robotrainer. Modalities are not yet activated!
+ In RViz, check the position of the robot on the map. Correct it manually, if necessary with '2D Pose Estimate'.
+ In rqt
  - Open dynamic reconfigure: Plugins > Configuration > Dynamic Reonfigure
  - Navigate to `/base` node
  - **Attention:** Before continuing, move the robot to a place where no virtual forces will be (check the scenario). Otherwise the robot might suddenly start moving.
  - check `use_modalities` in `\base` to activate modalities
  - Optional: Change speed and sensivity of the robot. Important: If you change something in `\base` make sure that you change the corrensponding values in the modality subnodes as well. Otherwise you e.g. might be able to drive through walls if you push hard enough. There are 3 preconfigured settings stored in YAML files for your convenience: slow (loaded by default), normal, fast.
    * Load base parameters from YAML file (click on folder icon): `base_slow` (default) or `base_normal` or `base_fast` in folder `<robotrainer>/yaml/rqt_params`
    * reload dynamic reconfigre (click on small reload icon in top right corner). Now you can see a new node `/modalities` with subnodes `virtual_areas`, `virtual_forces`, `virtual_walls`, `pathtracking`.
    * In each modality subnode, load parameters from the corresponding YAML file. Choose `<modality>_normal` if you've selected `base_normal` and so on.
  - **Modalities are now ready to go**
+ Stop Robot:
  - in rqt, uncheck `use_modalities` (otherwise modalities will be activated automaticly on next startup unless robot has been restarted.)
  - in Terminal 2: `Ctrl+C`


## Creating scenarios

+ Use robotrainer_editor (...) TODO

### Notes

+ Requirement to the path:
  - The distance of two pathpoints needs to be consistent and much smaller than max_deviation setting in a pathtracking section. Good value: 5cm.
  - The radius of a curve of the path should be a little bigger than max_deviation
+ Pathtracking
  - The robot will go into pathtracking mode if it comes within 30cm of the startpoint of a (pathtracking) section. You will feel it 'snap' to the startpoint. At the end of the section, the robot will leave the pathtracking mode.
  - There can be multiple section on a path. If the robot is in pathtracking mode on one section, it will ignore all other sections until the robot has reached the end of the tracked section.
+ Virtual Areas:
  - Attention when using invert_y: The robot should not be moved sideways (more than 45°) into the area or out of the area. Otherwise there will be bouncing at the area border.
  - Attention when using invert_direction: When moving the robot out of the area: Make sure not to move it vertical to entry-direction. Otherwise the robot will bouce back into the area (with new entry-direction). 

## Parameter Server

The following shows the params on parameter server that are relevant for the robotrainer.

```yaml
base: #Namespace of the FTS Controller
  use_modalities: true #default: false. Turn on/off the modalities.
robotrainer: #Common namespace for all robotrainer related params
  modalities_config: #Configuration valid for all elements of the corresponding modality. Dynamically reconfigurable in rqt.
    virtual_areas:
    virtual_forces:
      compensate_velocity: false
      compensation_reference_velocity: 0.3
      controller_update_rate: 100.0
      max_force: 110.0
      max_velocity: 0.8
      time_const_T: 0.6
      trapezoid_max_at_percent_radius: 0.25
    virtual_walls:
      controller_update_rate: 100
      max_force: 165
      max_velocity: 1.21
      time_const_T: 0.6
      trapezoid_max_at_percent_radius: 0.25
      wall_force: 165
    path_tracking:
      controller_update_rate: 100
      max_force: 110
      max_velocity: 1.21
      time_const_T: 0.6
  modalities_chain_config: #Configuration of the filter chain. Structure required by the filter chain. The order of the filters here defines the order of execution.
    - name: areas_modality
      type: robotrainer_modalities/VirtualAreasFilter
      params: {}
    - name: forces_modalitiy
      type: robotrainer_modalities/VirtualForcesFilter
      params: {}
    - name: walls_modality
      type: robotrainer_modalities/VirtualWallsFilter
      params: {}
    - name: pathtracking_modality
      type: robotrainer_modalities/PathTrackingFilter
      params: {}
  scenario: #Active scenario created in the robotrainer editor. When it gets changed on parameter server, the following service needs to be called in order to push the scenario to the modalities: /base/configure_modalities.
    #Both robotrainer_modalities and robotrainer_editor depend on this structure: the editor configures it, the modalities read it.
    area:
      config:
        area_names: [area_0]
      data:
        area_0:
          area: {X: -0.5, Y: 1.5, Z: 0.0} #area center point
          margin: {X: -0.5, Y: 0.8, Z: 0.0} #point on area margin  
          amplification: 1.0 #amplification of velocities within area
          invert_direction: false #Invert direction within area
          invert_rot: false #Invert rotation within area
          invert_y: false #Invert y-axis within area
          keep_direction: false #Keep the direction constant within area
          keep_rotation: false #Keep the rotation constant within area
    force: 
      config:
        display_path_file_name: /home/groten/path_yaml_test.yaml #relevant in editor but not for modalities
        force_names: [force_1]
        newton_per_meter: 30.0
      data:
        force_1:
          area: {X: -0.5, Y: 1.5, Z: 0.0} #area center point
          arrow: {X: 0, Y: -25.0, Z: 0.0} #relative force vector in Newton
          margin: {X: -0.5, Y: 0.8, Z: 0.0} #point on area margin     
          force_distance_function: 0 #0=trapezoidal 1=trigonometical 2=gaussian
    path:
      points: [point1, point2, point3]
      point1: {x: 0.32290059083819167, y: 0.024954837149349096, z: 0.0}
      point2: {x: 0.42197575569747503, y: 0.03852361410623921, z: 0.0}
      point3: {x: 0.5210509205567584, y: 0.05209239106312933, z: 0.0}
    section: #sections of the path in which pathtracking will be enabled
      config:
        section_names: [section_0]
      data:
        section_0:
          start: point1
          end: point3
          force_distance_function: 0 #0=linear 1=quadratic
          max_deviation: 0.5 #Maximum deviation from the path in meters, min=0.3
    wall:
      config:
        wall_names: [wall_0]
      data:
        wall_0:
          L: {X: 2 Y: -1.2, Z: 0.0}
          R: {X: -1.0, Y: 0.0, Z: 0.0}
          area: 
            area: 0.5
            cube: {X: 0.5, Y: 0.0, Z: 0.0} #not relevant for modalities
          force_distance_function: 0 #0=trapezoidal 1=trigonometical 2=gaussian

```
