cmake_minimum_required(VERSION 3.19...3.25)

get_property(is_multi_config GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
if(NOT is_multi_config AND NOT (CMAKE_BUILD_TYPE OR DEFINED ENV{CMAKE_BUILD_TYPE}))
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Release default")
endif()

project(METIS
LANGUAGES C
VERSION 5.2.1.0
DESCRIPTION "Sparse direct parallel solver"
HOMEPAGE_URL "https://github.com/KarypisLab/METIS"
)

enable_testing()

if(NOT ${PROJECT_NAME}_UPSTREAM_VERSION)
  set(${PROJECT_NAME}_UPSTREAM_VERSION 5.2.1)
endif()

option(BUILD_SHARED_LIBS "Build shared libraries")
option(BUILD_TESTING "Build METIS self-tests" ON)

if(NOT intsize)
  set(intsize 32)
endif()
if(NOT realsize)
  set(realsize 32)
endif()

# --- auto-ignore build directory
if(NOT EXISTS ${PROJECT_BINARY_DIR}/.gitignore)
  file(WRITE ${PROJECT_BINARY_DIR}/.gitignore "*")
endif()

install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/cmake/FindMETIS.cmake
DESTINATION cmake
)

# --- download source
include(cmake/gklib.cmake)
include(cmake/metis.cmake)

# --- inject CMakeLists.txt into downloaded source

configure_file(libmetis/CMakeLists.txt ${metis_SOURCE_DIR}/libmetis/ COPYONLY)
add_subdirectory(${metis_SOURCE_DIR}/libmetis ${metis_BINARY_DIR}/libmetis)


# --- feature summary

message(STATUS "CMake ${CMAKE_VERSION} METIS version: ${PROJECT_VERSION}  intsize ${intsize}  realsize ${realsize}")

include(cmake/install.cmake)
