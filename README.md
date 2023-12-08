# METIS

![ci](https://github.com/scivision/METIS/workflows/ci/badge.svg)

Modernizes CMakeLists.txt to work across operating systems and compilers.

```sh
cmake --workflow --preset default
```

which creates `build/libmetis.a`

## integer size, real size

By default, metis.h uses 32-bit integer and real. Each can be independently set to 32 or 64 bits like:

```sh
cmake -Bbuild -DIDXTYPEWIDTH=64 -DREALTYPEWIDTH=64
cmake --build build
```
