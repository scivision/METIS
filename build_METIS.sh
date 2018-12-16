#!/bin/bash

CC=gcc
CXX=g++

# Intel Compilers
# CC=$MKLROOT/../bin/intel64/icc
# CXX=$MKLROOT/../bin/intel64/icpc

set -e

(
cd metis-5.1.0

rm -rf build/*

make clean

make config CC=$CC CXX=$CXX

make -j -l4
)

