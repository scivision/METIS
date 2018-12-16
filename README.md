[![Build Status](https://travis-ci.com/scivision/METIS.svg?branch=master)](https://travis-ci.com/scivision/METIS)

# METIS

This repo is simply an archive of the METIS 5.1.0 library from the author's 
[website](http://glaros.dtc.umn.edu/gkhome/metis/metis/download).
This way, we have a "trusted" stable copy of METIS to obtain via CMake or Git for other repos we use/create.

The only IP we have created here is in the `build*.sh` scripts, also Apache licensed.


## Build

Instead of compiling, it's often easier to:

* Ubuntu: `apt install libmetis-dev`
* CentOS: `yum install metis-devel`

Otherwise you can compile Metis by:

```sh
cd metis
make config
make
```

which creates `libmetis/libmetis.a`

