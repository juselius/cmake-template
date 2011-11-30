cmake_minimum_required(VERSION 2.8)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_SOURCE_DIR}/cmake)

project(Example) 
enable_language(Fortran)

option(ENABLE_TESTS "Enable test suite" ON)
option(ENABLE_BLAS "Use BLAS backend for linear algebra" ON)
option(ENABLE_MPI "Enable MPI parallelization" OFF)
option(ENABLE_OPENMP "Enable OpenMP parallelization" OFF)
option(ENABLE_CODE_COVERAGE "Compile with code coverage turned on" OFF)

include(ConfigProjectVersion)
include(ConfigSafeGuards)
include(ConfigFortranCompilerFlags)

#set (NETCDF_F90 "YES")
#find_package(PythonInterp REQUIRED)
#find_package(HDF5 COMPONENTS Fortran)
#find_package(NetCDF)
if (ENABLE_MPI)
	find_package(MPI)
	if (MPI_FOUND)
		set(HAVE_MPI TRUE)
		include_directories(${MPI_INCLUDE_PATH})
	endif()
endif ()

if (ENABLE_OPENMP)
	find_package(OpenMP)
	if (OPENMP_FOUND)
		set(HAVE_OPENMP TRUE)
		set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} ${OpenMP_C_FLAGS}")
	endif()
endif ()

if (ENABLE_BLAS)
	if (BLAS_TYPE)
		find_package(BLAS COMPONENTS ${BLAS_TYPE})
	else()
		find_package(BLAS)
	endif()
endif ()

#add_definitions(-DTHIS_IS_CMAKE_BUILD)

set(CMAKE_Fortran_MODULE_DIRECTORY
	${PROJECT_BINARY_DIR}/modules
	)

include_directories(
	${PROJECT_BINARY_DIR}
	${PROJECT_BINARY_DIR}/modules
	)

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

if (EXISTS ${CMAKE_SOURCE_DIR}/cmake/ConfigPackaging.cmake)
	include(ConfigPackaging) 
endif()

# vim:ft=cmake
