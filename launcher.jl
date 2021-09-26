# The Dockerfile installs Pluto in a system-wide depot.
PLUTO_DEPOT = Base.DEPOT_PATH[2]

# For each package environment in our custom depot, we force-copy the
# environment to the first-listed depot, which lives on /var because it must be
# writable by the user.
import Pkg
Pkg.activate("pluto-env", shared=true)
origdir = Pkg.envdir(PLUTO_DEPOT)
envdir = Pkg.envdir()
mkpath(envdir)
for dir in readdir(origdir)
    rm("$envdir/$dir"; force=true, recursive=true)
    run(`cp -a $origdir/$dir $envdir/$dir`)
end

# Start Pluto with appropriate options
import Pluto
Pluto.run(
    port=8000,
    launch_browser=false,
    require_secret_for_access=false,
    dismiss_update_notification=true,
    show_file_system=false,
)
