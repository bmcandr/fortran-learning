! -------------------------------------------------------
!   Computes arithmetic, geometric and harmonic means
! -------------------------------------------------------

program means
    implicit none

    real :: x, y, z
    real :: ArithMean, GeoMean, HarmMean

    write(*,*) 'Enter three values:'
    read(*,*) x, y, z

    write(*,*)  'Data items: ', x, y, z
    write(*,*)

    ArithMean = (x + y + z) / 3.0
    GeoMean = (x * y * z)**(1.0 / 3.0)
    HarmMean = 3.0 / (1.0 / x + 1.0 / y + 1.0 / z)

    write(*,*) 'Arithmetic mean = ', ArithMean
    write(*,*) 'Geometric mean  = ', GeoMean
    write(*,*) 'Harmonic mean   = ', HarmMean

end program means