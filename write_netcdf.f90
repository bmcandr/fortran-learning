program write_netcdf
    
    use netcdf
    use check_mod
    
    implicit none

    integer :: status, ncid
    integer :: dimid_lon, dimid_lat 
    integer :: varid_lon, varid_lat, varid_field
    integer :: nx = 200
    integer :: ny = 101
    real, dimension(:), allocatable :: lon_array, lat_array
    real, dimension(:, :), allocatable :: field

    status = nf90_create('data/data.nc', NF90_NETCDF4, ncid)
    call check(status, 'open')

    call create_coords(ny, nx, lat_array, lon_array, field)
    
    ! add lon dimension 
    status = nf90_def_dim(ncid, 'longitude', nx, dimid_lon)
    call check(status, 'def lon')
    
    ! add lat dimension
    status = nf90_def_dim(ncid, 'latitude', ny, dimid_lat)
    call check(status, 'def lat')

    ! add variables
    status = nf90_def_var(ncid, 'longitude', NF90_FLOAT, [dimid_lon], varid_lon)
    call check(status, 'def var lon')

    status = nf90_def_var(ncid, 'latitude', NF90_FLOAT, [dimid_lat], varid_lat)
    call check(status, 'def var lat')

    status = nf90_def_var(ncid, 'field', NF90_FLOAT, [dimid_lon, dimid_lat], &
        varid_field)
    call check(status, 'def var field')
    
    ! add attributes
    status = nf90_put_att(ncid, NF90_GLOBAL, 'note', &
        'training file created with Fortran 90')
    call check(status, 'put note attr')

    status = nf90_put_att(ncid, varid_lon, 'units', 'degree_east')
    call check(status, 'put lon units attr')
    
    status = nf90_put_att(ncid, varid_lat, 'units', 'degree_north')
    call check(status, 'put lat units attr')

    status = nf90_put_att(ncid, varid_field, '_FillValue', -2e8)
    call check(status, 'put _FillValue attr')

    ! write variables
    status = nf90_put_var(ncid, varid_lon, lon_array)
    call check(status, 'write lon')

    status = nf90_put_var(ncid, varid_lat, lat_array)
    call check(status, 'write lat')

    status = nf90_put_Var(ncid, varid_field, field)
    call check(status, 'write field')

    ! close file
    status = nf90_close(ncid)
    call check(status, 'close')

    ! deallocate arrays
    deallocate(lat_array)
    deallocate(lon_array)
    deallocate(field)
    
    contains

    subroutine create_coords(ny, nx, lat_array, lon_array, field)
        
        implicit none
        
        integer :: i, j
        integer :: pi = 3.14156
        integer, intent(in) :: ny, nx
        real, dimension(:), allocatable, intent(inout) :: lon_array, lat_array
        real, dimension(:, :), allocatable, intent(inout) :: field
        
        allocate(lon_array(0:nx - 1))
        allocate(lat_array(0:ny - 1))
        allocate(field(0:nx-1, 0:ny-1))

        ! lon loop
        do i = 0, nx - 1

            lon_array(i) = i * (360. / (nx))
            
            ! lat loop
            do j = 0, ny - 1
                
                lat_array(j) = j * (180. / (ny - 1)) - 90
                 
                ! create field value
                field(i, j) = sin(lon_array(i) * pi / 180.) * &
                    cos(lat_array(j) * pi / 180.)
            
            end do
        end do

    end subroutine create_coords

end program write_netcdf
