FROM zenhack/sandstorm-http-bridge:276 as bridge

FROM julia:latest
RUN rmdir /home && \
    ln -fs /var /home && \
    julia -e 'pushfirst!(Base.DEPOT_PATH, "/pluto-depot"); import Pkg; Pkg.add(["Pluto", "PlutoUI"])' && \
    rm -rf /pluto-depot/environments
COPY --from=bridge /sandstorm-http-bridge /
COPY launcher.sh /
