#!/bin/bash
set -e
cd /home
exec /sandstorm-http-bridge 8000 -- julia /launcher.jl
