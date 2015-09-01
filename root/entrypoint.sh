#!/bin/bash
set -e

# To enable headless Firefox, have it run in virtual framebuffer.
# See http://www.semicomplete.com/blog/geekery/xvfb-firefox.html.
#
# Use the RESOLUTION environmental variable to customize screen size & depth. Default is "1024x768x24".
#

if [ -n "${RESOLUTION}" ]; then
    OPTS="-screen 0 ${RESOLUTION}"
fi

Xvfb :1 ${OPTS} &
export DISPLAY=:1

# So Firefox driver can find Firefox
export PATH=/firefox:$PATH

$@