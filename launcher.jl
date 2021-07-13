push!(Base.DEPOT_PATH, "/pluto-depot")
import Pkg
Pkg.add(name="Pluto", version=v"0.15.1")
Pkg.pin("Pluto")

import Pluto
Pluto.run(
    port=8000,
    launch_browser=false,
    require_secret_for_access=false,
    dismiss_update_notification=true,
    show_file_system=false,
)
