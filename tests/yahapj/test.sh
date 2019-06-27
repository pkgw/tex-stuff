#! /bin/bash
# Copyright 2019 Peter Williams <peter@newton.cx>
# Licensed under the MIT License

# Test the yahapj style file. We use Tectonic to process some refs and compare
# the BBL output to what's expected. The goal is to print nothing if everything
# is OK.

set -e
tectonic -c minimal --outfmt=xdv --keep-intermediates scaffold.tex
cmp scaffold.bbl expected.bbl
rm -f scaffold.{aux,bbl,xdv}
