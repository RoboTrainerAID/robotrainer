#!/usr/bin/python
import sys
import rospy
import json

import std_msgs

class RoboTrainerAggregator:
    def __init__(self):
        rospy.init_node("rosylernt_robotrainer_aggregator")
        self.rate = rospy.get_param("rate", 1)

        self.current_scenario_name = ""
        self.current_num_connections = 0

        self.scenario_pub = rospy.Publisher("scenario", std_msgs.msg.String, queue_size=0)

        rospy.Timer(rospy.Duration(1.0/self.rate), self.timer_callback)


    def timer_callback(self, timer_event):
        rt_scenario = rospy.get_param("/robotrainer/scenario", "");
        num_conn = self.scenario_pub.get_num_connections()

        # Publish only on change
        if self.current_scenario_name != rt_scenario["scenario"] or num_conn != self.current_num_connections:
            self.current_scenario_name = rt_scenario["scenario"]
            self.current_num_connections = num_conn
            self.scenario_pub.publish(json.dumps(rt_scenario));


def main(args):
    robotrainer_aggregator = RoboTrainerAggregator()

    rospy.spin()


if __name__ == "__main__":
    main(sys.argv)
