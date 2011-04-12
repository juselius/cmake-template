# - Find a LAPACK library 
#
# This module will first look in LAPACK_ROOT before considering the default 
# system pahts.
# The linker language can be defined by setting the varable LAPACK_LANG
#
# This module defines:
#
#  LAPACK_INCLUDE_DIRS Where to find lapack.h (or equivalent)
#  LAPACK_LIBRARIES Libraries to link against to use LAPACK
#  LAPACK_FOUND Defined if LAPACK is available 
#  HAVE_LAPACK To be used in #ifdefs 
#  LAPACK_H Name of LAPACK header file
#
# None of the above will be defined unless LAPACK can be found.
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

function(find_lapack lapack_types)
	foreach (lapack ${lapack_types})
		string(STRIP ${lapack} lapack)
		set(lapack_name "LAPACK-${lapack}")
		find_package(${lapack_name})
		if (LAPACK_FOUND)
			break()
		endif()
	endforeach()
endfunction()

if (LAPACK_INCLUDE_DIRS AND LAPACK_LIBRARIES)
  set(LAPACK_FIND_QUIETLY TRUE)
endif ()

if (DEFINED ENV{LAPACK_TYPE}) 
	if (NOT DEFINED LAPACK_TYPE})
		set(LAPACK_TYPE $ENV{LAPACK_TYPE})
	endif()
endif()

if (DEFINED LAPACK_TYPE) 
	set(lapack_types ${LAPACK_TYPE})
else()
	set(lapack_types MKL Atlas Goto Generic)
endif()

find_lapack("${lapack_types}")

unset(lapack_types)

if(LAPACK_LIBRARIES)
   set(LAPACK_FOUND TRUE)
endif()
