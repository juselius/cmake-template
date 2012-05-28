include(CheckFortranSourceCompiles)

if(ENABLE_SGI_MPT)
    set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -lmpi")
    set(CMAKE_C_FLAGS       "${CMAKE_C_FLAGS}       -lmpi")
    set(MPI_FOUND TRUE) # radovan: not so nice hack
endif()

if(ENABLE_MPI)
    find_package(MPI)
    if(MPI_FOUND)
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${MPI_COMPILE_FLAGS}")
    endif()
endif()

if(MPI_FOUND)
    add_definitions(-DVAR_MPI)
    include_directories(${MPI_INCLUDE_PATH})

    if(ENABLE_SANITY_CHECKS)
        # test whether MPI module is compatible with compiler
        exec_program(
            cat
            ARGS ${CMAKE_SOURCE_DIR}/cmake/parallel-environment/test-MPI-compiler-compatibility.F90
            OUTPUT_VARIABLE _source
            )
        check_fortran_source_compiles(
            ${_source}
            MPI_COMPILER_MATCHES
            )
        if(NOT MPI_COMPILER_MATCHES)
            message(
                FATAL_ERROR
                "ERROR: MPI incompatible - mpi.mod compiled with different compiler (consult the manual; if you know what you are doing you can disable this check using ./setup --nochecks)"
                )
        endif()

        # test whether MPI integer type matches
        exec_program(
            cat
            ARGS ${CMAKE_SOURCE_DIR}/cmake/parallel-environment/test-MPI-itype-compatibility.F90
            OUTPUT_VARIABLE _source
            )
        check_fortran_source_compiles(
            ${_source}
            MPI_ITYPE_MATCHES
            )
        if(NOT MPI_ITYPE_MATCHES)
            if(ENABLE_64BIT_INTEGERS)
                message("-- No 64-bit integer MPI interface found, will use 32-bit integer MPI interface")
                add_definitions(-DVAR_MPI_32BIT_INT)
            else()
                message(
                    FATAL_ERROR
                    "ERROR: You want to compile with 32bit integers but your MPI is built with 64bit integers (consult the manual; if you know what you are doing you can disable this check using ./setup --nochecks)"
                    )
            endif()
        endif()
    endif()

    if(ENABLE_32BIT_MPI_INTERFACE)
        if(ENABLE_64BIT_INTEGERS)
            message("-- 32-bit integer MPI interface activated by the user")
            add_definitions(-DVAR_MPI_32BIT_INT)
        endif()
    endif()

    if(ENABLE_MPI2_DETECTION)
        # test whether MPI-2 is available
        exec_program(
            cat
            ARGS ${CMAKE_SOURCE_DIR}/cmake/parallel-environment/test-MPI-2-compatibility.F90
            OUTPUT_VARIABLE _source
            )
        check_fortran_source_compiles(
            ${_source}
            MPI_2_COMPATIBLE
            )
        if(MPI_2_COMPATIBLE)
            add_definitions(-DVAR_MPI2)
            message("-- MPI-2 support found")
        else()
            message("-- no MPI-2 support found, will try with MPI-1")
        endif()
    else()
        message("-- MPI-2 support disabled, will try with MPI-1")
    endif()

endif()

if(ENABLE_OMP)
    find_package(OpenMP)
    if(OpenMP_FOUND)
        add_definitions(-DVAR_OMP)
        set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${OpenMP_COMPILE_FLAGS}")
        include_directories(${OpenMP_INCLUDE_PATH})
    endif()
endif()
