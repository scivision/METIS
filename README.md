# METIS

[![ci](https://github.com/scivision/METIS/actions/workflows/ci.yml/badge.svg)](https://github.com/scivision/METIS/actions/workflows/ci.yml)

Modernizes CMakeLists.txt to work across operating systems and compilers.

```sh
cmake --workflow default
```

which creates `build/libmetis.a`

## integer size, real size

By default, metis.h uses 32-bit integer and real.
Each can be independently set to 32 or 64 bits.
Your consuming project must also define these values at compile time, so that all parts of the project and subprojects are consistent.

```sh
cmake -Bbuild -DIDXTYPEWIDTH=64 -DREALTYPEWIDTH=64
cmake --build build
```
