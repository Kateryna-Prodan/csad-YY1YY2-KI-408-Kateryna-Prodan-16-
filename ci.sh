#!/bin/bash
set -e

mkdir -p build
cd build

cmake ..
cmake --build .

# Замість голого `ctest`:
if ctest -N | grep -q "unit_tests"; then
  ctest -R unit_tests --output-on-failure
else
  echo "No unit_tests target, skipping tests"
fi
