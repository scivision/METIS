include(ExternalProject)
include(GNUInstallDirs)

set(name gklib)

file(READ ${CMAKE_CURRENT_LIST_DIR}/libraries.json json)

string(JSON ${name}_url GET ${json} ${name} "url")
string(JSON ${name}_tag GET ${json} ${name} "tag")


message(DEBUG "${name} archive source URL: ${${name}_url}   tag: ${${name}_tag}")

set(${name}_args
-DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
-DBUILD_SHARED_LIBS:BOOL=${BUILD_SHARED_LIBS}
-DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
-DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_INSTALL_PREFIX}
)
set(flags ${CMAKE_C_FLAGS})
if(MINGW)
  string(APPEND flags " -DUSE_GKREGEX")
endif()
if(CMAKE_C_COMPILER_ID STREQUAL "GNU")
  string(APPEND flags " -std=c99 -fno-strict-aliasing")
endif()

if(BUILD_SHARED_LIBS)
  set(${name}_LIBRARIES ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/${CMAKE_SHARED_LIBRARY_PREFIX}${name}${CMAKE_SHARED_LIBRARY_SUFFIX})
else()
  set(${name}_LIBRARIES ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_LIBDIR}/${CMAKE_STATIC_LIBRARY_PREFIX}${name}${CMAKE_STATIC_LIBRARY_SUFFIX})
endif()

ExternalProject_Add(${name}
GIT_REPOSITORY ${${name}_url}
GIT_TAG ${${name}_tag}
GIT_SHALLOW true
CMAKE_ARGS ${${name}_args} -DCMAKE_C_FLAGS=${flags}
BUILD_BYPRODUCTS ${${name}_LIBRARIES}
TLS_VERIFY true
CONFIGURE_HANDLED_BY_BUILD true
GIT_REMOTE_UPDATE_STRATEGY "CHECKOUT"
INACTIVITY_TIMEOUT 60
)

file(MAKE_DIRECTORY ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_INCLUDEDIR})

add_library(${name}::${name} INTERFACE IMPORTED)
set(PROPERTY TARGET ${name}::${name} PROPERTY INTERFACE_LINK_LIBRARIES ${${name}_LIBRARIES})
set(PROPERTY TARGET ${name}::${name} PROPERTY INTERFACE_INCLUDE_DIRECTORIES ${${name}_INCLUDE_DIRS})

add_dependencies(${name}::${name} ${name})
