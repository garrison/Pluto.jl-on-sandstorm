FROM zenhack/sandstorm-http-bridge:276 as bridge

FROM julia:1.6.2

# We're going to set HOME=/home, so let's make it point to /var, which
# is the only writable location inside a grain.
RUN rmdir /home && ln -fs /var /home

# We wish to install Pluto in its own package depot.  We set
# JULIA_DEPOT_PATH to have as its first entry a system-wide depot, as
# Pkg commands modify the first-specified depot.  This modified
# JULIA_DEPOT_PATH will not be passed to the grain (see
# sandstorm-pkgdef.capnp for that environment), but it will be set for
# all subsequent commands in this Dockerfile, as well as when the
# julia REPL is started from the resulting Docker image.  The latter
# fact can be used to upgrade the Manifest.toml by running from the
# container:
#
#     julia> import Pkg; Pkg.update()
#
# The resulting Manifest.toml must then be extricated from this
# container and into the source directory.  From the host:
#
#     $ docker cp container-name:/usr/local/julia/local/share/julia/environments/pluto-env/Manifest.toml .
#
ENV PLUTO_DEPOT=${JULIA_PATH}/local/share/julia
ENV JULIA_DEPOT_PATH=${PLUTO_DEPOT}:
COPY Project.toml Manifest.toml ${PLUTO_DEPOT}/environments/pluto-env/
RUN \
    julia -e '\
    import Pkg; \
    Pkg.activate("pluto-env"; shared=true); \
    Pkg.instantiate(); \
    # Set up the runner\'s environment; this is typically included from
    # Pluto/src/evaluation/WorkspaceManager.jl
    import Pluto; \
    include(joinpath(dirname(pathof(Pluto)), "runner", "Loader.jl")); \
    '

COPY --from=bridge /sandstorm-http-bridge /
COPY launcher.sh launcher.jl /

# Now that the image is built, we set an environment variable which
# will only be in effect when somebody starts a julia REPL using this
# container, which they might do for the goal of updating the package
# manifest.  In this case, precompilation is unnecessary because the
# goal is to get a Manifest.toml which can be extracted from the
# container into the source directory (see above).
ENV JULIA_PKG_PRECOMPILE_AUTO=0
