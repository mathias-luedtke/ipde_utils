# Tutorial: Deploying an example package

A [RobotWebTools](http://robotwebtools.org/) example package can be found in `demo/rwt_interactive_markers`.
It bundles the interactive markers demo as a ROS package with a simple web interface.

## High-level use
1. Start server (see [setup.md](setup.md))
2. Change into main directory, e.g. `cd ~/ipde_utils`
3. If you are using Docker Toolbox (Win or Mac), you have to `export IPDE_SESSIONS_URI=http://192.168.99.100:8000/sessions/`
4. `./launch.sh im_test demo/rwt_interactive_markers demo.launch`, this will pull all dependencies and start `demo.launch`
5. Wait for "Starting factory <twisted.web.server.Site instance"
6. Visit http://127.0.0.1:8080/ (or http://192.168.99.100:8080/)
7. Stop your example by hitting ctrl+c

You have been running an interactive marker demo with rosbrigde and a simple webserver without installing any of these on your host machine, you don't even need ROS for running it.

## Low-level use
So let's have a look under the hood.

If you run `./list.sh` you see your session, named `im_test`. This session label can be arbitrary, but should not contain spaces.

`./launch.sh` is a convenience wrapper for scripts that can be run indiviually.

First your local code needs to be deployed into a session:
`./deploy.sh im_test2 demo/rwt_interactive_markers demo.launch`.
This finds or creates a session named `im_test2`.
Then it retrieves the packaes name in `demo/rwt_interactive_markers`, you can as well provide a package name directly. In this case the directory will get found with `rospack`.
Next `demo.launch` gets located inside this direcory.
This way the session can be configured to launch `$(find rwt_interactive_markers)/launch/demo.launch`
Finally your source code from the directory gets uploaded into your session.

`./list.sh` will now return `(im_test2): build_state="none" configured="true" created="true" modified="true" run_state="none"`

Now you have to build your session:
`./build im_test2`
This will pull dependencies again, but it will be faster because of the apt cache.
`./list.sh` will now confirm your build has completed `(im_test2): build_state="done" configured="true" created="true" modified="false" run_state="none"`

In case you want to review the log output again, you can use `./logs.sh im_test2 build`.

Finally you might want to run your session:
`./run.sh im_test2`
You can now visit the web interface again.
If you press ctrl+c now, the session will keep running.
`./list.sh` shows `(im_test2): build_state="done" configured="true" created="true" modified="false" run_state="in_progress"`.

You have to stop it explicitly with `./stop.sh im_test2`.
The status can be confirmed with `./list.sh` again: `(im_test2): build_state="done" configured="true" created="true" modified="false" run_state="done"`
Of course, you can review the logs again: `./logs.sh im_test2 run`.

## Clean-up

If you're done with your tests, you can clean-up you sessions.
**This removes all data, logs, container and images**
`./rm.sh im_test im_test2`
