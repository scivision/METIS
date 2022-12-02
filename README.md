# METIS

![ci](https://github.com/scivision/METIS/workflows/ci/badge.svg)

Modernizes
[METIS 5.1.0](http://glaros.dtc.umn.edu/gkhome/metis/metis/download)
build system to work on Linux and MacOS and Windows Subsystem for Linux.

## Prereqs

A C99 compiler, such as GCC, Clang, Visual Studio, Intel oneAPI

## Build

```sh
cmake -B build

cmake --build build --parallel
```

which creates `build/libmetis.a`

## integer size, real size

By default, metis.h uses 32-bit integer and real. Each can be independently set to 32 or 64 bits like:

```sh
cmake -Bbuild -Dintsize=64 -Drealsize=64
cmake --build build
```
