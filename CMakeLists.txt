cmake_minimum_required(VERSION 3.12)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()

project(METIS
LANGUAGES C
HOMEPAGE_URL http://glaros.dtc.umn.edu/gkhome/metis/metis/download)

include(CTest)

set(GKLIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src/GKlib CACHE PATH "path to GKlib")
option(SHARED "build a shared library" false)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

set(CMAKE_C_STANDARD 99)

if(MSVC)
  set(METIS_INSTALL FALSE)
else()
  set(METIS_INSTALL TRUE)
endif()

# Configure libmetis library.
if(SHARED)
  set(METIS_LIBRARY_TYPE SHARED)
else()
  set(METIS_LIBRARY_TYPE STATIC)
endif(SHARED)

include(${GKLIB_PATH}/GKlibSystem.cmake)
# Add include directories.
include_directories(${GKLIB_PATH})
include_directories(src/include)
# Recursively look for CMakeLists.txt in subdirs.
add_subdirectory(src/include)
add_subdirectory(src/libmetis)
add_subdirectory(src/programs)

add_test(NAME GraphCheck
COMMAND $<TARGET_FILE:graphchk> ${CMAKE_CURRENT_SOURCE_DIR}/src/tests/tiny_01.graph)
