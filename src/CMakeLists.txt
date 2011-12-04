include_directories(${BLAS_INCLUDE_DIRS})

add_library(hello STATIC 
    hello.c
    hello.h
    )

add_executable(example.bin example.c)
target_link_libraries(example.bin hello ${BLAS_LIBRARIES})

set (PROGRAM_EXECUTABLE ${CMAKE_INSTALL_PREFIX}/bin/example.bin)
set (INST_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/example.in example)

# This is the "developer" wrapper program
set (PROGRAM_EXECUTABLE ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/example.bin)
set (INST_LIBDIR ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
configure_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/example.in 
    ${PROJECT_BINARY_DIR}/example
    )
execute_process(COMMAND chmod 755 ${PROJECT_BINARY_DIR}/example OUTPUT_QUIET) 

install(TARGETS example.bin
    RUNTIME DESTINATION bin
    CONFIGURATIONS Release
    )

install(PROGRAMS example
    DESTINATION bin
    CONFIGURATIONS Release
    )

