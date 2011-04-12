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
include(BlasFunctions)

if (BLAS_LANG STREQUAL "C")
	set(blas_h cblas.h)
endif()

set(path_suffixes lib lib/atlas)
if (BLAS_LANG STREQUAL "C")
	set(blas_libs cblas atlas f77blas)
else()
	set(blas_libs atlas f77blas)
endif()

find_blas_header()
find_blas_libs()

unset(blas_libs)
unset(path_suffixes)

cache_blas_result(Atlas)

