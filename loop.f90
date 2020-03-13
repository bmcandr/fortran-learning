program loop

    ! a simple program that takes user input for i, j, and step
    ! loops from i to j at step and prints i on each loop

    ! create empty integer variables
    INTEGER :: i, j, step
    
    ! take user input to set i
    print *, "Enter a starting point:"
    read *, i
    
    ! take user input to set j
    print *, "Enter a ending point:"
    read *, j
    
    ! take user input to set step
    print *, "Enter a step:"
    read *, step

    ! loop from i to j by step
    ! print i in each loop    
    DO WHILE (i .LE. j)
        print *, i
        i = i + step
    END DO
    
end program
