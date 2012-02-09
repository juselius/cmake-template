execute_process(
    COMMAND python ${CMAKE_SOURCE_DIR}/cmake/configuration-info/get_compiler_version.py ${CMAKE_Fortran_COMPILER}
    TIMEOUT 1
    OUTPUT_VARIABLE FORTRAN_COMPILER_VERSION
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
    COMMAND python ${CMAKE_SOURCE_DIR}/cmake/configuration-info/get_compiler_version.py ${CMAKE_C_COMPILER}
    TIMEOUT 1
    OUTPUT_VARIABLE C_COMPILER_VERSION
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

configure_file(
    ${CMAKE_SOURCE_DIR}/cmake/configuration-info/compilation_info.py.in
    ${CMAKE_BINARY_DIR}/compilation_info.py
    )
execute_process(
    COMMAND python ${CMAKE_BINARY_DIR}/compilation_info.py
    TIMEOUT 1
    OUTPUT_FILE ${CMAKE_SOURCE_DIR}/gp/compilation_info.F90
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

if(VERBOSE_OUTPUT)
    # get compilation info to cmake output
    execute_process(
        COMMAND python ${CMAKE_BINARY_DIR}/compilation_info.py
        TIMEOUT 1
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
    # get last git revision to cmake output
    execute_process(
        COMMAND cat ${CMAKE_SOURCE_DIR}/main/config.h
        TIMEOUT 1
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )
endif()
