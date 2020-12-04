module check_mod
    
    use netcdf
    
    implicit none

    contains

    subroutine check(status, operation)
        
        implicit none
        
        integer, intent(in) :: status

        character(len=*), intent(in) :: operation

        if (status == NF90_NOERR) return
        
        write (*,*) "Error encountered during ", operation
        write (*,*) nf90_strerror(status)
        STOP 1
    end subroutine check

end module check_mod
