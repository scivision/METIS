cmake_minimum_required(VERSION 3.1)
project(GKlib)

get_filename_component(abs "." ABSOLUTE)
set(GKLIB_PATH ${abs})
unset(abs)
include(GKlibSystem.cmake)

add_library(GKlib STATIC ${GKlib_sources})
target_link_libraries(GKlib PRIVATE $<$<BOOL:${UNIX}>:m>)
target_include_directories(GKlib PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})

if(BUILD_TESTING)
  add_subdirectory(test)
endif()

install(TARGETS GKlib
  ARCHIVE DESTINATION lib
  LIBRARY DESTINATION lib)
install(FILES ${GKlib_includes} DESTINATION include)
