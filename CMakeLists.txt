cmake_minimum_required(VERSION 3.12)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()

project(METIS
LANGUAGES C
HOMEPAGE_URL http://glaros.dtc.umn.edu/gkhome/metis/metis/download)

include(CTest)

# --- auto-ignore build directory
if(NOT EXISTS ${PROJECT_BINARY_DIR}/.gitignore)
  file(WRITE ${PROJECT_BINARY_DIR}/.gitignore "*")
endif()

set(GKLIB_PATH ${CMAKE_CURRENT_SOURCE_DIR}/src/GKlib CACHE PATH "path to GKlib")

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR})

set(CMAKE_C_STANDARD 99)

# Configure libmetis library.
if(BUILD_SHARED_LIBS)
  set(METIS_LIBRARY_TYPE SHARED)
else()
  set(METIS_LIBRARY_TYPE STATIC)
endif()

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
