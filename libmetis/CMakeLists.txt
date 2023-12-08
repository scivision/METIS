# Find sources.
file(GLOB metis_sources *.c)
# Build libmetis.
add_library(metis ${METIS_LIBRARY_TYPE} ${GKlib_sources} ${metis_sources})
target_include_directories(metis PUBLIC
$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
$<INSTALL_INTERFACE:include>
PRIVATE ${PROJECT_SOURCE_DIR}/include ${gklib_SOURCE_DIR}
)
target_link_libraries(metis
PRIVATE
GKlib
$<$<BOOL:${UNIX}>:m>
)

install(TARGETS metis)
