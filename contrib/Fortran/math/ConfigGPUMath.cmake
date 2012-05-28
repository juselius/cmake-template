if(ENABLE_CUDA)
    find_package(CUDA)
    if(CUDA_FOUND)
        if(NOT ENABLE_64BIT_INTEGERS)
            # for CUDA we are employing variables set and returned by FindCUDA.cmake
            add_library(fortran_cuda "${CUDA_TOOLKIT_ROOT_DIR}/src/fortran.c" "${CUDA_TOOLKIT_ROOT_DIR}/src/fortran.h")
            INCLUDE_DIRECTORIES( ${CUDA_INCLUDE_DIRS} )
            #message("CUDA_CUBLAS_LIBRARIES=${CUDA_CUBLAS_LIBRARIES}")
            set(CULA_LIB_DIRS Empty)
            if (ENABLE_CULA) # both CUDA & CULA present
                # miro: there is no FindCULA yet - we are using hardcoded default installation links
                add_definitions(-DUSE_CULA)
                INCLUDE_DIRECTORIES( /usr/local/cula/include )
                if (CUDA_64_BIT_DEVICE_CODE)  # set 64bit according to CUDA prerequisite
                    set(CULA_LIB_DIR /usr/local/cula/lib64 )
                else()
                    set(CULA_LIB_DIR /usr/local/cula/lib )
                endif()
                find_library(CULA NAMES cula PATHS ${CULA_LIB_DIR} )
                find_library(CULA_FORTRAN NAMES cula_fortran PATHS ${CULA_LIB_DIR} )
                find_library(CULA_BLAS NAMES cublas PATHS ${CULA_LIB_DIR} )
                find_library(CULA_CUDART NAMES cudart PATHS ${CULA_LIB_DIR} )
                #message("CULA_CUDART=${CULA_CUDART}")
                #message("CULA=${CULA}")
            endif()
            add_definitions(-DUSE_CUBLAS)
            if (CUDA_64_BIT_DEVICE_CODE)
                add_definitions(-DARCH_64)
            endif()
            # fortran executable with some routines in C to check all GPU possibilities
            add_executable(gpu_test.x utils/gpu_test.F90 utils/gpu_routines.c)
            if (ENABLE_CULA) # both CUDA & CULA present
                # "CULA is built on NVIDIA CUDAand NVIDIA CUBLAS", but it can also be linked against  newer CUDA libraries
                # miro: we have two linking possibilities, explore them
                target_link_libraries(gpu_test.x fortran_cuda ${LIBS} ${CULA} ${CULA_FORTRAN} ${CULA_BLAS} ${CULA_CUDART} blas lapack) # employ solely own stuff from CULA ...
                #target_link_libraries(gpu_test.x fortran_cuda ${LIBS} ${CULA} ${CULA_FORTRAN} ${CUDA_CUBLAS_LIBRARIES} ${CUDA_LIBRARIES} blas lapack) # employ some stuff from CUDA
            else() # linking against sole CUDA
                target_link_libraries(gpu_test.x fortran_cuda ${LIBS} ${CUDA_CUBLAS_LIBRARIES} ${CUDA_LIBRARIES} blas)
            endif()
        else()
            message("-- CUDA library found, but can not be used with 64-bit integers!")
        endif()
    endif()
endif()
