# - Find a BLAS library 
#
# This module will first look in BLAS_ROOT before considering the default 
# system pahts.
# The linker language can be defined by setting the varable BLAS_LANG
#
# This module defines:
#
#  BLAS_INCLUDE_DIRS Where to find blas.h (or equivalent)
#  BLAS_LIBRARIES Libraries to link against to use BLAS
#  BLAS_FOUND Defined if BLAS is available 
#  HAVE_BLAS To be used in #ifdefs 
#  BLAS_H Name of BLAS header file
#
# None of the above will be defined unless BLAS can be found.
# 
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

function(find_blas blas_types)
	foreach (blas ${blas_types})
		string(STRIP ${blas} blas)
		set(blas_name "BLAS-${blas}")
		find_package(${blas_name})
		if (BLAS_FOUND)
			break()
		endif()
	endforeach()
endfunction()

if (BLAS_INCLUDE_DIRS AND BLAS_LIBRARIES)
  set(BLAS_FIND_QUIETLY TRUE)
endif ()

if (DEFINED ENV{BLAS_TYPE}) 
	if (NOT DEFINED BLAS_TYPE})
		set(BLAS_TYPE $ENV{BLAS_TYPE})
	endif()
endif()

if (DEFINED BLAS_TYPE) 
	set(blas_types ${BLAS_TYPE})
else()
	set(blas_types MKL Atlas Goto Generic)
endif()

find_blas("${blas_types}")

unset(blas_types)
