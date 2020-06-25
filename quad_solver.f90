! -------------------------------------------------------
! Solve ax^2 + bx + c = 0 given b*b-4*a*c >= 0
! -------------------------------------------------------

program quad_solver
    implicit none

    real :: a, b, c
    real :: d
    real :: root1, root2

    ! Read in the coefficients a, b, and c

    write(*,*) 'Enter values for a, b, and c:'
    read(*,*) a, b, c

    ! Compute the square root of discriminant d

    d = sqrt(b*b - 4.0*a*c)

    ! Solve the equation

    root1 = (-b + d) / (2.0 * a)    ! first root
    root2 = (-b - d) / (2.0 * a)    ! second root

    ! Display the results

    write(*,*)
    write(*,*) 'Roots are ', root1, ' and ', root2

end program quad_solver