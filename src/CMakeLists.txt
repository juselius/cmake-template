set (EXAMPLE_SOURCES 
	hello.c
	hello.h
)

include_directories(${BLAS_INCLUDE_DIRS})

add_library(hello STATIC ${EXAMPLE_SOURCES})

add_executable(example.bin example.c)
target_link_libraries(example.bin hello ${BLAS_LIBRARIES})

set (PROGRAM_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/example.bin)
set (INST_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
configure_file(${CMAKE_SOURCE_DIR}/src/example.in example)

# This is the "developer" wrapper program
set (PROGRAM_EXECUTABLE ${CMAKE_BINARY_DIR}/src/example.bin)
set (INST_LIBDIR ${CMAKE_SOURCE_DIR}/lib)
configure_file(
	${CMAKE_SOURCE_DIR}/src/example.in 
	${CMAKE_BINARY_DIR}/example
	)
execute_process(COMMAND chmod 755 ${CMAKE_BINARY_DIR}/example OUTPUT_QUIET) 

install(TARGETS example.bin
	RUNTIME DESTINATION bin
	CONFIGURATIONS Release
	)

install(PROGRAMS example
	DESTINATION bin
	CONFIGURATIONS Release
	)

