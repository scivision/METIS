# These programs use internal metis data structures.

# Try to find subversion revision.
set(SVNREV "")
file(TO_NATIVE_PATH ${PROJECT_SOURCE_DIR}/.svn svn_dir)
if(IS_DIRECTORY ${svn_dir})
  include(FindSubversion)
  if(Subversion_FOUND)
    Subversion_WC_INFO(${PROJECT_SOURCE_DIR} metis)
    set(SVNREV ${metis_WC_REVISION})
  endif(Subversion_FOUND)
endif()

add_executable(gpmetis gpmetis.c cmdline_gpmetis.c io.c stat.c)
add_executable(ndmetis ndmetis.c cmdline_ndmetis.c io.c smbfactor.c)
add_executable(mpmetis mpmetis.c cmdline_mpmetis.c io.c stat.c)
add_executable(m2gmetis m2gmetis.c cmdline_m2gmetis.c io.c)
add_executable(graphchk graphchk.c io.c)
add_executable(cmpfillin cmpfillin.c io.c smbfactor.c)
foreach(prog IN ITEMS gpmetis ndmetis mpmetis m2gmetis graphchk cmpfillin)
  target_link_libraries(${prog} PRIVATE metis)
  target_include_directories(${prog} PRIVATE
    ${PROJECT_SOURCE_DIR}/src/GKlib
    ${PROJECT_BINARY_DIR}/src/include
    )
  target_compile_definitions(${prog} PRIVATE SVNINFO="${SVNREV}")
#  target_link_libraries(${prog} metis profiler)
endforeach(prog)

install(TARGETS gpmetis ndmetis mpmetis m2gmetis graphchk cmpfillin)
