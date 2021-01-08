# METIS

![ci](https://github.com/scivision/METIS/workflows/ci/badge.svg)

Modernizes
[METIS 5.1.0](http://glaros.dtc.umn.edu/gkhome/metis/metis/download)
build system to work on Linux and MacOS and Windows Subsystem for Linux.

## Prereqs

A C compiler.

## Build

```sh
cmake -B build

cmake --build build --parallel
```

which creates `build/libmetis.a`
