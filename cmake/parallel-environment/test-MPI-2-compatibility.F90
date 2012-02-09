      program MPI2_TEST
      implicit real*8 (A-H,O-Z)
      include 'mpif.h'
      INTEGER MPIERR
      INTEGER ISTATUS(MPI_STATUS_SIZE)

      INTEGER MYID, NELEMENT
      INTEGER NPROC, NAMELENGTH
      INTEGER AMATL, XMATL, MY_X_WIN
      PARAMETER (mx_size_m=100000000)
#if !defined (SYS_AIX) && !defined (SYS_IBM)
      INTEGER(KIND=MPI_ADDRESS_KIND) ptr1, ptr2
#endif
      POINTER (ptr1, xmat(mx_size_m))
      POINTER (ptr2, ymat(mx_size_m))
      INTEGER(kind=MPI_ADDRESS_KIND) MY_MM_NEEDSSCR, MY_yy_NEEDSSCR
      INTEGER*8 NELEMENT8, MY_yy_NEEDS, MY_MM_NEEDS
      INTEGER ISSIZE_R8, I_ONE, I_FILE_LEN, MY_MPI_FH
      CHARACTER*72 MACHINENAME
      CHARACTER*9 MY_FILE_NM_L
      CHARACTER*11 MY_FILE_NM

      NAMELENGTH = 0
      NELEMENT   = 0
      MYID       = 0
      NPROC      = 0
      ISSIZE_R8  = 0

      CALL MPI_INIT(MPIERR)
      CALL MPI_COMM_RANK(MPI_COMM_WORLD, MYID,  MPIERR)
      CALL MPI_COMM_SIZE(MPI_COMM_WORLD, NPROC, MPIERR)

      CALL MPI_GET_PROCESSOR_NAME(MACHINENAME,NAMELENGTH,MPIERR)

!     write my hostname
      write(*,*) ' Processor ',MYID,' is running on host ', &
       MACHINENAME(1:NAMELENGTH)

      MY_MM_NEEDS    = 0
      MY_MM_NEEDSSCR = 0

      NELEMENT = 10000000

!     determine number of elements NELEMENT REAL*8 (8 byte long)
      NELEMENT8 = NELEMENT

!     real*8 in bytes
      CALL MPI_TYPE_EXTENT(MPI_REAL8,ISSIZE_R8,MPIERR)

!     memory allocation (in bytes): NELEMENT8 * byte-length
      MY_MM_NEEDSSCR = ISSIZE_R8 * NELEMENT8

      MY_MM_NEEDS    = MY_MM_NEEDSSCR
      MY_yy_NEEDS    = MY_MM_NEEDS

!     allocate memory
      CALL MPI_ALLOC_MEM(MY_MM_NEEDS,MPI_INFO_NULL,ptr1,MPIerr)
      CALL MPI_ALLOC_MEM(MY_yy_NEEDS,MPI_INFO_NULL,ptr2,MPIerr)

!     fill matrices
      DO JI = 1, NELEMENT
        xmat(JI) = 1.0D0
      END DO

!     open memory window
      CALL MPI_WIN_CREATE(xmat,MY_MM_NEEDS,8,MPI_INFO_NULL, &
                          MPI_COMM_WORLD,MY_X_WIN,MPIERR)

!     lock window (MPI_LOCK_SHARED mode)
!     select target ==> if itarget == myid: no 1-sided communication
      ITARGET = MYID + 1
      IF( ITARGET .ge. NPROC ) ITARGET = 0

      CALL MPI_WIN_LOCK(MPI_LOCK_SHARED,ITARGET,MPI_MODE_NOCHECK, &
                        MY_X_WIN,MPIERR)

!     transfer data from target ITARGET
      JCOUNT_T = NELEMENT8

      JCOUNT   = JCOUNT_T
      CALL MPI_GET(YMAT,JCOUNT,MPI_REAL8,ITARGET,0,JCOUNT_T, &
                    MPI_REAL8, MY_X_WIN, MPIERR)

!     unlock
      CALL MPI_WIN_UNLOCK(ITARGET,MY_X_WIN,MPIERR)

!     free memory window
      CALL MPI_WIN_FREE(MY_X_WIN,MPIERR)

!     de-allocate
      CALL MPI_FREE_MEM(xmat,MPIERR)
      CALL MPI_FREE_MEM(ymat,MPIERR)

!     test MPI file handling
      MY_FILE_NM_L = 'localfile'
      I_ONE        = 1

      WRITE (MY_FILE_NM,'(A9,A1,I1)') MY_FILE_NM_L,'.',I_ONE

      I_FILE_LEN = 11

      CALL MPI_FILE_OPEN(MPI_COMM_WORLD, MY_FILE_NM(1:I_FILE_LEN), &
                         MPI_MODE_WRONLY + MPI_MODE_CREATE, &
                         MPI_INFO_NULL, MY_MPI_FH, MPIERR)

      CALL MPI_FILE_CLOSE(MY_MPI_FH,MPIERR)

      call MPI_FINALIZE(MPIERR)

      end program
