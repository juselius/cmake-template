program raboof
!  this program won't compile if integer types don't match
   implicit none
contains
   function get_my_rank()
      use mpi
      integer :: get_my_rank
      integer :: irank
      integer :: ierr
      call mpi_comm_rank(mpi_comm_world, irank, ierr)
      get_my_rank = irank
   end function
end program
