* This is a fork of METIS from before when METIS was on [GitHub](https://github.com/KarypisLab/METIS).
* The goal is to avoid modifying C code and headers unless necessary, focusing instead on build scripts and configuration files to maintain compatibility with our fork.

* Upstream can take years if ever to merge straightforward fixes, especially to CMake script that's quite broken in upstream.
* Also there are C header and code fixes we've had to make, so regrettably we have sort of parallel GKlib and METIS to upstream, though we'd rather upstream fix itself.
* We prefer to keep our fork functional and compatible with our projects rather than waiting for upstream to catch up.
* We aim to maintain upstream METIS compatibility with our fork while also keeping an eye on potential upstream changes.

## Testing

* Static tests are run by `cmake --workflow default`
* Shared tests are important regardless of platform, executed by `cmake --workflow shared`
* On Windows, it's important to test with both MSYS2 (GCC and/or Clang) as well as MSVC `cmake --workflow msvc` and `cmake --workflow msvc-shared`
