configure_file(metis.h.in metis.h @ONLY)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/metis.h TYPE INCLUDE)
