#!/bin/bash
set -e
cd /home
/sandstorm-http-bridge 8000 -- julia -e "push!(Base.DEPOT_PATH, \"/pluto-depot\"); import Pkg; Pkg.add([\"Pluto\", \"PlutoUI\"]); import Pluto; Pluto.run(port=8000, launch_browser=false, require_secret_for_access=false, dismiss_update_notification=true, show_file_system=false)"
