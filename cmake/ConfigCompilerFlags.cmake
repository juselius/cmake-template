include(SaveCompilerFlags)

if (CMAKE_C_COMPILER_WORKS)
    include(${PROJECT_SOURCE_DIR}/cmake/compilers/CFlags.cmake)
endif()

if (CMAKE_CXX_COMPILER_WORKS)
    include(${PROJECT_SOURCE_DIR}/cmake/compilers/CXXFlags.cmake)
endif()

if (CMAKE_Fortran_COMPILER_WORKS)
    include(${PROJECT_SOURCE_DIR}/cmake/compilers/FortranFlags.cmake)
endif()

if (CMAKE_C_COMPILER_ID MATCHES Intel OR
        CMAKE_CXX_COMPILER_ID MATCHES Intel OR
        CMAKE_Fortran_COMPILER_ID MATCHES Intel)
    set (CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -shared-intel")
endif()
