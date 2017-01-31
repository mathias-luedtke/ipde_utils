# Tutorial: Running a remote package

This tutorial requires the basics from the  [RWT tutorial](rwt_tutorial.md).
We will now lauch an external package without any local data.

For now there is no High-level script available, so we have to use the Low-level scripts.
In this example we are going to run the STDR simulator.

First we have to configure our session:

`./create_external.sh stdr stdr_launchers launch/server_with_map_and_gui_plus_robot.launch demo/.rosinstall`

This works almost like `./launch.sh` and `./deploy.sh`, but it requires the second argument to be the name of a package and the third to a be package-relative path.
The last argument uplads a `.rosinstall` that points to the code on Github.
The latter is required to pull a bugfix that is not yet released. In addtion it provides `teleop_twist_keyboard `.

Afterwards we can proceed with `./build.sh stdr`.
It will take some time to pull all dependencies and build the nodes.
Anf the end of the build it will take some additional time to commit the container to an image, so be patient.
Finally we can start it with  `./run.sh stdr`.
Please note, stdr_gui_node will crash right-away in the container as X forwarding is not configured.

You can enter the running Docker container: `docker exec -it deploy-stdr-run /bin/bash`
In there, you should source the ROS environment first: `source /usr/local/bin/setup.bash`
Please prepare two shells with with environment.
In the first, print the odometry: `rostopic echo -c /robot0/odom/pose/pose`.
In the other, control the robot: `rosrun teleop_twist_keyboard teleop_twist_keyboard.py cmd_vel:=robot0/cmd_vel`

 If you have ROS an your machine, you can use RVIZ to see the maps, links and other data from the simulation.
