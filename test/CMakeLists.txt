include(LocalBuildTree)
include(ConfigureScript)
include_directories (${PROJECT_SOURCE_DIR}/src)

add_executable(test.bin test.c)
target_link_libraries(test.bin hello)

# shell test script
configure_script(test.sh.in ${CMAKE_CURRENT_BINARY_DIR}/test.sh)

# Python test script
configure_script(test.py.in ${CMAKE_CURRENT_BINARY_DIR}/test.py)

if (MPI_FOUND)
    if (DEFINED ENV{MPIEXEC_PREFLAGS})
        separate_arguments(args UNIX_COMMAND $ENV{MPIEXEC_PREFLAGS})
        set (MPIEXEC_PREFLAGS ${args})
        unset(args)
    endif()
    if (DEFINED MPI_NUMPROC OR DEFINED $ENV{MPI_NUMPROC})    
        set (MPIRUN ${MPIEXEC} ${MPIEXEC_PREFLAGS} 
            ${MPIEXEC_NUMPROC_FLAG} ${MPI_NUMPROC} 
            )
    else()
        set (MPIRUN ${MPIEXEC} ${MPIEXEC_PREFLAGS})
    endif()
endif()

add_test(NAME ExampleTests 
    COMMAND ${MPIRUN} ${CMAKE_CURRENT_BINARY_DIR}/test.sh 
    WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/test
    )
