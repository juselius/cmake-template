include(LocalBuildTree)
include_directories (${PROJECT_SOURCE_DIR}/src)

add_custom_target(tests ALL 
    DEPENDS test.bin
    )

add_executable(test.bin test.c)
target_link_libraries(test.bin hello)

# shell test script
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/test.sh.in
    ${CMAKE_CURRENT_BINARY_DIR}/test.sh @ONLY
    )
execute_process(COMMAND 
    chmod 755 ${CMAKE_CURRENT_BINARY_DIR}/test.sh OUTPUT_QUIET) 

# Python test script
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/test.sh.in
    ${CMAKE_CURRENT_BINARY_DIR}/test.sh @ONLY
    )
execute_process(COMMAND 
    chmod 755 ${CMAKE_CURRENT_BINARY_DIR}/test.sh OUTPUT_QUIET) 


add_test(NAME ExampleTests 
    COMMAND ${CMAKE_CURRENT_BINARY_DIR}/test.sh 
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/tests
    )

if (MPI_FOUND)
    set(MPIEXEC_NUMPROC 4)
    set (MPIRUN ${MPIEXEC} ${MPIEXEC_PREFLAGS} 
        ${MPIEXEC_NUMPROC_FLAG} ${MPI_NUMPROC} 
        )
endif()
