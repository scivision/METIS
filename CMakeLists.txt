cmake_minimum_required(VERSION 3.25...4.5)

if(NOT CMAKE_BUILD_TYPE AND NOT DEFINED ENV{CMAKE_BUILD_TYPE})
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()

if(CMAKE_VERSION VERSION_GREATER_EQUAL 4.3)
  # https://spdx.github.io/spdx-spec/v3.0.1/annexes/spdx-license-expressions/
  set(_spdx_license SPDX_LICENSE "Apache-2.0")
endif()

project(METIS
LANGUAGES C
VERSION 5.2.1.4
${_spdx_license}
)
# based on upstream e0f1b88b8efcb24ffa0ec55eabb78fbe61e58ae7

include(GNUInstallDirs)
include(FetchContent)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT AND METIS_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/local" CACHE PATH "install prefix" FORCE)
endif()

option(METIS_BUILD_TESTING "Build METIS self-tests")

message(STATUS "${PROJECT_NAME} ${PROJECT_VERSION} CMake ${CMAKE_VERSION} install prefix ${CMAKE_INSTALL_PREFIX}")

file(READ ${CMAKE_CURRENT_SOURCE_DIR}/cmake/libraries.json _json)
string(JSON gklib_url GET "${_json}" "gklib")
FetchContent_Declare(GKlib URL ${gklib_url})
FetchContent_MakeAvailable(GKlib)


set(CMAKE_C_STANDARD 99)

if(NOT DEFINED IDXTYPEWIDTH)
  set(IDXTYPEWIDTH 32)
endif()
if(NOT DEFINED REALTYPEWIDTH)
  set(REALTYPEWIDTH 32)
endif()

configure_file(include/metis.h.in metis.h @ONLY)

include(conf/gkbuild.cmake)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/metis.h TYPE INCLUDE)

# Build libmetis.
add_library(metis)
add_subdirectory(libmetis)
target_include_directories(metis PUBLIC
"$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/libmetis;${CMAKE_CURRENT_BINARY_DIR}>"
$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
target_link_libraries(metis PUBLIC GKlib::GKlib $<$<BOOL:${UNIX}>:m>)
if(CMAKE_VERSION VERSION_GREATER_EQUAL 4.1)
  set_target_properties(metis PROPERTIES SPDX_LICENSE "Apache-2.0")
endif()

add_library(METIS::METIS ALIAS metis)

install(TARGETS metis EXPORT ${PROJECT_NAME}-targets)

add_subdirectory(programs)

if(METIS_BUILD_TESTING)
  enable_testing()

  add_test(NAME GraphCheck COMMAND $<TARGET_FILE:graphchk> ${CMAKE_CURRENT_SOURCE_DIR}/test/tiny_01.graph)
endif()

include(cmake/install.cmake)

file(GENERATE OUTPUT .gitignore CONTENT "*")
