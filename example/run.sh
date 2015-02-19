#!/bin/bash
set -ex
#
# This script runs the appliance's setup procedure as if a user interacts with the appliance's Web pages. It exits 0
# only if the test succeeds.
#

if [ $# != 2 ]; then
    (set +x
        echo "Usage: $0 <hostname> <screenshots_output_dir>"
        echo "       <hostname> hostname of the appliance under test. It must be consistent with the CNAME of the browser"
        echo "                  cert defined in appliance.yml otherwise tests would fail."
        echo "       <screenshots_output_dir> where the script will dump screenshots to"
    )
    exit 11
fi
HOST="$1"
SCREEN_SHOTS="$2"

# Docker requires absolute paths. OSX has no realpath command.
THIS_DIR="$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)"

mkdir -p "${SCREEN_SHOTS}"
rm -rf "${SCREEN_SHOTS}"/*
SCREEN_SHOTS="$(cd "${SCREEN_SHOTS}" && pwd)"

docker build -t config-appliance "${THIS_DIR}"

# CI uses dnsmasq to resolve the appliance's hostname. Since the container is unaware of dnsmasq we resolve the hostname
# manually. Alternatively, configure the container to poing to dnsmasq.
IP="$(dig +short ${HOST})"
[[ -n "${IP}" ]] || (
    echo "Couldn't find IP of hostname ${HOST}. Please check DNS settings."
    exit 22
)

(set +e
    docker run --rm \
        -v "${THIS_DIR}/../../../packaging/bakery/development/test.license":/test.license \
        -v "${THIS_DIR}/appliance.yml":/appliance.yml \
        -v "${SCREEN_SHOTS}":/screenshots \
        --add-host "${HOST}:${IP}" \
        config-appliance /run.sh "${HOST}" /screenshots /test.license /appliance.yml
    EXIT_CODE=$?

    (set +x
        [[ ${EXIT_CODE} = 0 ]] && RES=SUCCESS || RES=FAILED
        echo
        echo ">>> ${RES}. Screenshots are at ${SCREEN_SHOTS}"
        echo
    )

    exit ${EXIT_CODE}
)