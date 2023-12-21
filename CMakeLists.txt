cmake_minimum_required(VERSION 3.14...3.28)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()

project(metis
LANGUAGES C
VERSION 5.2.1.1
)
# based on upstream e0f1b88b8efcb24ffa0ec55eabb78fbe61e58ae7

enable_testing()

include(FetchContent)

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT AND metis_IS_TOP_LEVEL)
  set(CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/local" CACHE PATH "install prefix" FORCE)
endif()

option(BUILD_TESTING "Build METIS self-tests" ON)

message(STATUS "${PROJECT_NAME} ${PROJECT_VERSION} CMake ${CMAKE_VERSION} install prefix ${CMAKE_INSTALL_PREFIX}")

FetchContent_Declare(GKlib
GIT_REPOSITORY https://github.com/scivision/GKlib.git
GIT_TAG 6897bfe
GIT_SHALLOW true
)
FetchContent_MakeAvailable(GKlib)

set(CMAKE_C_STANDARD 99)

add_compile_definitions(
"REALTYPEWIDTH=$<IF:$<BOOL:${REALTYPEWIDTH}>,${REALTYPEWIDTH},32>"
"IDXTYPEWIDTH=$<IF:$<BOOL:${IDXTYPEWIDTH}>,${IDXTYPEWIDTH},32>"
)

include(conf/gkbuild.cmake)

install(FILES include/metis.h TYPE INCLUDE)

# Build libmetis.
add_library(metis)
target_include_directories(metis PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/libmetis>
$<INSTALL_INTERFACE:include>
PRIVATE ${PROJECT_SOURCE_DIR}/include ${gklib_SOURCE_DIR}
)
target_link_libraries(metis
PUBLIC GKlib
PRIVATE $<$<BOOL:${UNIX}>:m>
)

install(TARGETS metis EXPORT ${PROJECT_NAME}-targets)

add_subdirectory(libmetis)
add_subdirectory(programs)

# add_test(NAME GraphCheck
# COMMAND $<TARGET_FILE:graphchk> ${CMAKE_CURRENT_SOURCE_DIR}/src/tests/tiny_01.graph)

include(cmake/install.cmake)

file(GENERATE OUTPUT .gitignore CONTENT "*")
