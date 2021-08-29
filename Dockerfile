FROM zenhack/sandstorm-http-bridge:276 as bridge

FROM julia:latest
RUN \
    # We're going to set HOME=/home, so let's make it point to /var,
    # which is the only writable location inside a grain.
    rmdir /home && ln -fs /var /home && \
    # Install Pluto in its own package depot
    julia -e '\
    pushfirst!(Base.DEPOT_PATH, "/usr/local/pluto-depot"); \
    import Pkg; \
    Pkg.add(url="https://github.com/garrison/Pluto.jl", rev="v0.15.1-sandstorm"); \
    # Set up the runner\'s environment; this is typically included from
    # Pluto/src/evaluation/WorkspaceManager.jl
    import Pluto; \
    include(joinpath(dirname(pathof(Pluto)), "runner", "Loader.jl")); \
    '
COPY --from=bridge /sandstorm-http-bridge /
COPY launcher.sh launcher.jl /
