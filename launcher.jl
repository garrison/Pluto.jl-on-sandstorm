PLUTO_DEPOT = "/usr/local/pluto-depot"
insert!(Base.DEPOT_PATH, 2, PLUTO_DEPOT)

import Pkg
origdir = Pkg.envdir(PLUTO_DEPOT)
envdir = Pkg.envdir()
mkpath(envdir)
for dir in readdir(origdir)
    rm("$envdir/$dir"; force=true, recursive=true)
    run(`cp -a $origdir/$dir $envdir/$dir`)
end

import Pluto
Pluto.run(
    port=8000,
    launch_browser=false,
    require_secret_for_access=false,
    dismiss_update_notification=true,
    show_file_system=false,
)
