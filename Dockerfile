FROM zenhack/sandstorm-http-bridge:238 as bridge

FROM julia:latest
RUN julia -e 'import Pkg; Pkg.add(["Pluto", "PlutoUI"])'
COPY --from=bridge /sandstorm-http-bridge /
COPY launcher.sh /
