[Pluto.jl] reactive [Julia] notebooks, packaged as a [Sandstorm] app.

[Pluto.jl]: https://plutojl.org/
[Julia]: https://julialang.org/
[Sandstorm]: https://sandstorm.io/

### Technical notes

This app is built with Docker.  Originally, we used [docker-spk], but
it is actually a bit more convenient to call Docker ourselves, at
least for now.  Like [dotnet-docker-spk], we need to work around
`/proc` being unavailable, as julia assumes it exists (via
`uv_exepath`).  The following command builds the package and provides
it to the local Sandstorm development instance:

    ./build-oldspk.sh && spk dev

[docker-spk]: https://github.com/zenhack/docker-spk
[dotnet-docker-spk]: https://github.com/zenhack/dotnet-docker-spk
