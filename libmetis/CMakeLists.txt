add_library(metis
auxapi.c        debug.c         graph.c       meshpart.c  pmetis.c     stdheaders.h
balance.c       defs.h          initpart.c    metislib.h  proto.h      struct.h
bucketsort.c    fm.c            kmetis.c      minconn.c   refine.c     timing.c
checkgraph.c    fortran.c       kwayfm.c      mincover.c  rename.h     util.c
CMakeLists.txt  frename.c       kwayrefine.c  mmd.c       separator.c  wspace.c
coarsen.c       gklib.c         macros.h      ometis.c    sfm.c
compress.c      gklib_defs.h    mcutil.c      options.c   srefine.c
contig.c        gklib_rename.h  mesh.c        parmetis.c  stat.c
)
target_link_libraries(metis PRIVATE gklib::gklib)

install(TARGETS metis
EXPORT ${PROJECT_NAME}-targets
)
