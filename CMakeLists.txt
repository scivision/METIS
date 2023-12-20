cmake_minimum_required(VERSION 3.14...3.28)

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Debug or Release")
endif()

project(METIS
LANGUAGES C
VERSION 5.2.1.1
)
# based on upstream e0f1b88b8efcb24ffa0ec55eabb78fbe61e58ae7

enable_testing()

include(FetchContent)

FetchContent_Declare(GKlib
GIT_REPOSITORY https://github.com/scivision/GKlib.git
GIT_TAG 44630ca
GIT_SHALLOW true
)
FetchContent_MakeAvailable(GKlib)

option(BUILD_TESTING "Build METIS self-tests" ON)

set(CMAKE_C_STANDARD 99)

add_compile_definitions(
"REALTYPEWIDTH=$<IF:$<BOOL:${REALTYPEWIDTH}>,${REALTYPEWIDTH},32>"
"IDXTYPEWIDTH=$<IF:$<BOOL:${IDXTYPEWIDTH}>,${IDXTYPEWIDTH},32>"
)

include(conf/gkbuild.cmake)

install(FILES include/metis.h TYPE INCLUDE)

add_subdirectory(libmetis)
add_subdirectory(programs)

# add_test(NAME GraphCheck
# COMMAND $<TARGET_FILE:graphchk> ${CMAKE_CURRENT_SOURCE_DIR}/src/tests/tiny_01.graph)

file(GENERATE OUTPUT .gitignore CONTENT "*")
