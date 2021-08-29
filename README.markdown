[Pluto.jl] reactive [Julia] notebooks, packaged as a [Sandstorm] app.

[Pluto.jl]: https://plutojl.org/
[Julia]: https://julialang.org/
[Sandstorm]: https://sandstorm.io/

### Technical notes

This app is built with [docker-spk].  Like [dotnet-docker-spk], we need to work around `/proc` being unavailable, as julia assumes it exists (via `uv_exepath`).  The following command builds the package:

    rm -fr oldspk && docker build --no-cache . && docker-spk build --out .oldspk.spk && spk unpack .oldspk.spk oldspk && spk pack Pluto.jl-0.15.1.spk

[docker-spk]: https://github.com/zenhack/docker-spk
[dotnet-docker-spk]: https://github.com/zenhack/dotnet-docker-spk
