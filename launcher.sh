#!/bin/bash
set -e
cd $HOME
exec /sandstorm-http-bridge 8000 -- julia /launcher.jl
