execute_process(
    COMMAND python ${CMAKE_SOURCE_DIR}/cmake/get_compiler_version.py ${CMAKE_Fortran_COMPILER}
    TIMEOUT 1
    OUTPUT_VARIABLE FORTRAN_COMPILER_VERSION
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND python ${CMAKE_SOURCE_DIR}/cmake/get_compiler_version.py ${CMAKE_C_COMPILER}
    TIMEOUT 1
    OUTPUT_VARIABLE C_COMPILER_VERSION
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

configure_file(
    ${CMAKE_SOURCE_DIR}/cmake/compilation_info.py.in
    ${CMAKE_BINARY_DIR}/compilation_info.py
    )
execute_process(
    COMMAND python ${CMAKE_BINARY_DIR}/compilation_info.py
    TIMEOUT 1
    OUTPUT_FILE ${CMAKE_SOURCE_DIR}/gp/compilation_info.F90
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

execute_process(
    COMMAND python ${CMAKE_SOURCE_DIR}/cmake/get_last_rev.py ${CMAKE_SOURCE_DIR}
    TIMEOUT 1
    OUTPUT_VARIABLE LAST_GIT_REVISION
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

configure_file(
    ${CMAKE_SOURCE_DIR}/cmake/git_revision_info.py.in
    ${CMAKE_BINARY_DIR}/git_revision_info.py
    )
execute_process(
    COMMAND python ${CMAKE_BINARY_DIR}/git_revision_info.py
    TIMEOUT 1
    OUTPUT_FILE ${CMAKE_SOURCE_DIR}/gp/git_revision_info.F90
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
