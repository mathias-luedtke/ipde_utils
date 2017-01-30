# ipde_utils CLI reference

## Install dependencies
The required dependencies should be already available on most platforms.
For ubuntu you can insall them with: `sudo apt-get install -y bash tar curl sed`

## Scripts

*All scripts read the `IPDE_SESSIONS_URI` environment variable to override the default URI `http://127.0.0.1:8000/sessions/`*

### General scripts
#### helper.bash
Variaous REST api functions, is meant to be sourced.

#### ./list.sh
Print all sessions and their state

#### ./stop.sh
`./stop.sh label`

Stops the running session with the given name und print the output.

#### ./logs.sh
`./logs.sh label [build|run] [tail]`

Print the build or run logs for the given session.
For stopped builds/runs the log can be truncated with the tail argument, otherwise logs get streamed.

#### ./rm.sh
`./rm.sh label`

Deletes the session with the given name.

### High level scripts
#### ./launch.sh
`./launch.sh label package launch_file [extra_paths *]`

Deploys, builds and runs the launchfile.
If the scrpt if interrupted (ctrl+c), the launchfile will be stopped.
#### ./testing.sh

Like `launch.sh`, but creates and runs testing session.


### Low-level scripts

#### ./deploy.sh
`./deploy.sh label package launch_file [extra_paths *]`

Creates/overwrite a session with the given label.
Package can be a name (**Needs ROS setup.bash to be sourced**) or a directory.
The second and third arguments denote the main package and launch file.
All extra paths get uploaded into the session.
VCS paths and hidden files are exluded per default and have to be listed explicitly.

#### ./create_external.sh
`./create_external.sh label package launch_file [extra_paths *]`

Cretae session that uses released packagem cannot resolve launch file paths automatically.

#### ./create_test.sh
`./create_test.sh label package [extra_paths *]`

Like `deploy.sh`, but uses creates testing session for given package.

#### ./build.sh
`./build.sh label`

Builds the session with the given name und print the output.
**Stopping the script  does not stop the build!**

#### ./run.sh
`./run.sh label`

Runs the session with the given name und print the output.
If another session is already running, it will be stopped.
**Stopping the script does not stop the run!**
