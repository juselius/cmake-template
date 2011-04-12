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
# None of the above will be defined unless BLAS can be found.
# 
# This module accepts the COMPONENTS flag, whereby a specific (set) of BLAS 
# implementation(s) can be requested (e.g. find_package(BLAS COMPONENTS MKL))
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

function(find_blas)
	foreach (blas ${BLAS_FIND_COMPONENTS})
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

if (NOT BLAS_FIND_COMPONENTS) 
	set(BLAS_FIND_COMPONENTS MKL Atlas Goto Generic)
endif()

find_blas()

