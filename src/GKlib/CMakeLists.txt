cmake_minimum_required(VERSION 3.14)
project(GKlib LANGUAGES C)

set(GKLIB_PATH ${PROJECT_SOURCE_DIR})

include(GKlibSystem.cmake)

add_library(GKlib STATIC ${GKlib_sources})
target_link_libraries(GKlib PRIVATE $<$<BOOL:${UNIX}>:m>)
target_include_directories(GKlib PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

if(BUILD_TESTING)
  add_subdirectory(test)
endif()

install(TARGETS GKlib)
install(FILES ${GKlib_includes} TYPE INCLUDE)
