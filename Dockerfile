FROM zenhack/sandstorm-http-bridge:238 as bridge

FROM julia:latest
RUN rmdir /home && \
    ln -fs /var /home && \
    julia -e 'import Pkg; Pkg.add(["Pluto", "PlutoUI"])'
COPY --from=bridge /sandstorm-http-bridge /
COPY launcher.sh /
