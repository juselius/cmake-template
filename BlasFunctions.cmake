#=============================================================================
# Copyright 2011 Jonas Juselius <jonas.juselius@uit.no>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distributed this file outside of CMake, substitute the full
#  License text for the above reference.)

if (EXISTS $ENV{BLAS_ROOT})
    if (NOT DEFINED BLAS_ROOT})
        set(BLAS_ROOT} $ENV{BLAS_ROOT})
    endif()
endif()

if (NOT BLAS_LANG)
	set(BLAS_LANG C)
elseif(BLAS_LANG STREQUAL "C" OR BLAS_LANG STREQUAL "CXX")
	set(BLAS_LANG C)
elseif(NOT BLAS_LANG STREQUAL "Fortran")
	message(FATAL_ERROR "Invalid BLAS linker langugae: ${BLAS_LANG}")
endif()

macro(find_blas_header)
	find_path(BLAS_INCLUDE_DIRS
		NAMES ${BLAS_H_NAME}
		PATHS ${BLAS_ROOT}
		PATH_SUFFIXES include
		NO_DEFAULT_PATH
		)
	find_path(BLAS_INCLUDE_DIRS 
		NAMES ${BLAS_H_NAME}
		)
endmacro()

macro(find_blas_libs)
	foreach(blaslib ${blas_libs})
		find_library(_lib ${blaslib}
			PATHS ${BLAS_ROOT}
			PATH_SUFFIXES ${path_suffixes}
			NO_DEFAULT_PATH
			)
		find_library(_lib ${blaslib} 
			PATH_SUFFIXES ${path_suffixes}
			)
		if(_lib)
			set(BLAS_LIBRARIES ${BLAS_LIBRARIES} ${_lib})
			unset(_lib CACHE)
		else()
			break()
		endif()
	endforeach()
	unset(blaslib)
	unset(_lib CACHE)
endmacro()

macro(cache_blas_result blas_type)
	include(FindPackageHandleStandardArgs)
	if (BLAS_H_NAME)
		find_package_handle_standard_args(BLAS 
			"Could NOT find ${blas_type} BLAS"
			BLAS_INCLUDE_DIRS BLAS_LIBRARIES BLAS_H_NAME)
	else()
		find_package_handle_standard_args(BLAS 
			"Could NOT find ${blas_type} BLAS" BLAS_LIBRARIES)
	endif()

	if (BLAS_FOUND) 
		set(HAVE_BLAS ON CACHE INTERNAL "Defined if BLAS is available")
		set(BLAS_LIBRARIES ${BLAS_LIBRARIES} CACHE STRING "BLAS libraries")
		mark_as_advanced(BLAS_LIBRARIES)
		if (BLAS_H_NAME)
        	set(BLAS_H_NAME ${BLAS_H_NAME} CACHE STRING "Name of BLAS header")
        	set(BLAS_INCLUDE_DIRS ${BLAS_INCLUDE_DIRS} 
				CACHE STRING "BLAS include directory")
			mark_as_advanced(BLAS_INCLUDE_DIRS BLAS_H_NAME)
		endif()
	endif()
endmacro()
