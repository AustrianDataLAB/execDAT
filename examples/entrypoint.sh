#!/bin/bash

# This script is the entrypoint for the container. It is run when the container is started.
echo "Starting entrypoint.sh" > /output/entrypoint.log

# trying to copy the input file to the output file from https://www.wien.gv.at/finanzen/ogd/hunde-wien.csv
cp /input/hunde-wien.csv /output/hunde-wien.csv
