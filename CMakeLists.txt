cmake_minimum_required(VERSION 3.14...3.28)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()

project(METIS
LANGUAGES C
VERSION 5.1.0.4
)

enable_testing()

option(BUILD_TESTING "Build METIS self-tests" ON)

if(NOT intsize)
  set(intsize 32)
endif()
if(NOT realsize)
  set(realsize 32)
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
#include_directories(${GKLIB_PATH})
# Recursively look for CMakeLists.txt in subdirs.
add_subdirectory(src/include)
add_subdirectory(src/libmetis)
add_subdirectory(src/programs)

add_test(NAME GraphCheck
COMMAND $<TARGET_FILE:graphchk> ${CMAKE_CURRENT_SOURCE_DIR}/src/tests/tiny_01.graph)

file(GENERATE OUTPUT .gitignore CONTENT "*")
