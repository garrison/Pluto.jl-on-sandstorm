#!/bin/bash
set -e
cd /home
/sandstorm-http-bridge 8000 -- julia /launcher.jl
