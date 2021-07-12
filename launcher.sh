#!/bin/bash
set -e
cd /home
if [[ ! -f .julia ]]
then
    # First time starting grain
    cp -r /root/.julia .
fi
/sandstorm-http-bridge 8000 -- julia -e "import Pkg; Pkg.status(); import Pluto; Pluto.run(port=8000, launch_browser=false, require_secret_for_access=false)"
