include(LocalBuildTree)
include(ConfigureScript)
include_directories (${PROJECT_SOURCE_DIR}/src)

add_custom_target(tests ALL 
    DEPENDS test.bin
    )

add_executable(test.bin test.c)
target_link_libraries(test.bin hello)

# shell test script
configure_script(test.sh)

# Python test script
configure_script(test.py)

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
