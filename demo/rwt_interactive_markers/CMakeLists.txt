cmake_minimum_required(VERSION 2.8.3)

project(rwt_interactive_markers)

find_package(catkin REQUIRED)
catkin_package()

install(DIRECTORY launch html
        DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
       )

install(PROGRAMS scripts/webserver
        DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
       )
