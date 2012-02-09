program raboof
!  this program won't compile if compilers do not match
   implicit none
contains
   subroutine foo()
      use mpi
      print *, 'oof'
   end subroutine
end program
