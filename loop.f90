program loop
    INTEGER :: i, j, step
    
    print *, "Enter a starting point:"
    read *, i
    
    print *, "Enter a ending point:"
    read *, j
    
    print *, "Enter a step:"
    read *, step
    
    
    DO WHILE (i .LE. j)
        print *, i
        i = i + step
    END DO
    
end program
