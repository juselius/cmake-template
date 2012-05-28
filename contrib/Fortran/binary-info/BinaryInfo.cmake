include(ConfigGitRevision)

execute_process(
    COMMAND whoami
    TIMEOUT 1
    OUTPUT_VARIABLE USER_NAME
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND hostname
    TIMEOUT 1
    OUTPUT_VARIABLE HOST_NAME
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND python ${CMAKE_SOURCE_DIR}/cmake/binary-info/get_compiler_version.py ${CMAKE_Fortran_COMPILER}
    TIMEOUT 1
    OUTPUT_VARIABLE FORTRAN_COMPILER_VERSION
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
    COMMAND python ${CMAKE_SOURCE_DIR}/cmake/binary-info/get_compiler_version.py ${CMAKE_C_COMPILER}
    TIMEOUT 1
    OUTPUT_VARIABLE C_COMPILER_VERSION
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

configure_file(
    ${CMAKE_SOURCE_DIR}/cmake/binary-info/binary_info.py.in
    ${CMAKE_BINARY_DIR}/binary_info.py
    )
execute_process(
    COMMAND python ${CMAKE_BINARY_DIR}/binary_info.py
    TIMEOUT 1
    OUTPUT_FILE ${CMAKE_SOURCE_DIR}/src/gp/binary_info.F90
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

if(VERBOSE_OUTPUT)
    # get binary info to cmake output (for the dashboard)
    execute_process(
        COMMAND python ${CMAKE_BINARY_DIR}/binary_info.py
        TIMEOUT 1
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
endif()
