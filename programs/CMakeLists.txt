# These programs use internal metis data structures.

add_executable(gpmetis gpmetis.c cmdline_gpmetis.c io.c stat.c)
add_executable(ndmetis ndmetis.c cmdline_ndmetis.c io.c smbfactor.c)
add_executable(mpmetis mpmetis.c cmdline_mpmetis.c io.c stat.c)
add_executable(m2gmetis m2gmetis.c cmdline_m2gmetis.c io.c)
add_executable(graphchk graphchk.c io.c)
add_executable(cmpfillin cmpfillin.c io.c smbfactor.c)
foreach(prog IN ITEMS gpmetis ndmetis mpmetis m2gmetis graphchk cmpfillin)
  target_link_libraries(${prog} PRIVATE metis)
  target_include_directories(${prog} PRIVATE ${gklib_SOURCE_DIR} ${PROJECT_SOURCE_DIR}/include)
#  target_link_libraries(${prog} metis profiler)
endforeach(prog)

install(TARGETS gpmetis ndmetis mpmetis m2gmetis graphchk cmpfillin)
