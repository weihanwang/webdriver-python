#!/bin/bash
set -e

# To enable headless Firefox, have it run in virtual framebuffer.
# See http://www.semicomplete.com/blog/geekery/xvfb-firefox.html.
Xvfb :1 &
export DISPLAY=:1

# So Firefox driver can find Firefox
export PATH=/firefox:$PATH

$@