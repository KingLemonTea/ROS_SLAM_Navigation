#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/parallels/turtlebot3/src/turtlebot3/turtlebot3_example"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/parallels/turtlebot3/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/parallels/turtlebot3/install/lib/python3/dist-packages:/home/parallels/turtlebot3/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/parallels/turtlebot3/build" \
    "/usr/bin/python3" \
    "/home/parallels/turtlebot3/src/turtlebot3/turtlebot3_example/setup.py" \
     \
    build --build-base "/home/parallels/turtlebot3/build/turtlebot3/turtlebot3_example" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/parallels/turtlebot3/install" --install-scripts="/home/parallels/turtlebot3/install/bin"
