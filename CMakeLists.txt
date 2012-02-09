cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

project(Example) 
enable_language(CXX)

set (PROJECT_VERSION_MAJOR 0)
set (PROJECT_VERSION_MINOR 0)
set (PROJECT_VERSION_PATCH 0)

option(ENABLE_TESTS "Enable test suite" ON)
option(ENABLE_GTEST "Enable Googel-test" OFF)
option(ENABLE_BLAS "Use BLAS backend for linear algebra" ON)
option(ENABLE_MPI "Enable MPI parallelization" OFF)
option(ENABLE_OPENMP "Enable OpenMP parallelization" OFF)
option(ENABLE_CODE_COVERAGE "Compile with code coverage turned on" OFF)

include(ConfigProjectVersion)
include(ConfigSafeGuards)
include(ConfigCompilerFlags)

#set (NETCDF_CXX YES)
#set(Boost_USE_MULTITHREADED OFF)

#find_package(PythonInterp REQUIRED)
#find_package(Eigen3)
#find_package(Boost REQUIRED serialization)
#find_package(HDF5 COMPONENTS CXX)
#find_package(NetCDF)

if (ENABLE_MPI)
    find_package(MPI)
    if (MPI_FOUND)
        #find_package(Boost REQUIRED mpi)
        set(HAVE_MPI TRUE)
        include_directories(${MPI_INCLUDE_PATH})
    endif()
endif ()

if (ENABLE_OPENMP)
    find_package(OpenMP)
    if (OPENMP_FOUND)
        set(HAVE_OPENMP TRUE)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
    endif()
endif ()

if (ENABLE_BLAS)
    if (BLAS_TYPE)
        find_package(BLAS COMPONENTS "${BLAS_TYPE}")
    else()
        find_package(BLAS)
    endif()
endif ()

include(CommonBuildTree)

add_subdirectory(src)

if (ENABLE_TESTS)
    set (PROJECT_REPOSITORY "https://git.example.com/example")
    include(ConfigTesting)
    add_subdirectory(tests)
endif()

include(ConfigGitRevision)

configure_file (
    ${PROJECT_SOURCE_DIR}/config.h.in
    ${PROJECT_BINARY_DIR}/config.h
    )

set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "")
set(CPACK_PACKAGE_VENDOR "")
set(CPACK_PACKAGE_CONTACT "")
set(CPACK_PACKAGE_EXECUTABLES "" "Description")
set(CPACK_PACKAGE_URL "http://example.com")
set(CPACK_PACKAGE_DESCRIPTION_FILE ${CMAKE_CURRENT_SOURCE_DIR}/INSTALL.rst)
set(CPACK_RESOURCE_FILE_README ${CMAKE_CURRENT_SOURCE_DIR}/README.rst)
set(CPACK_RESOURCE_FILE_LICENSE ${CMAKE_CURRENT_SOURCE_DIR}/COPYING)
set(CPACK_GENERATOR TGZ DEB RPM)
include(ConfigPackaging) 
