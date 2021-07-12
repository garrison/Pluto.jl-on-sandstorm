#!/bin/bash
set -e
cd /var
/sandstorm-http-bridge 8000 -- julia -e "import Pluto; Pluto.run(port=8000, launch_browser=false, require_secret_for_access=false)"
