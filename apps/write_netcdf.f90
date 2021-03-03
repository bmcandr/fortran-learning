program write_netcdf
    
    use netcdf
    use checkStatus_mod
    
    implicit none

    integer :: deflate_level = 2
    logical :: compress = .true.

    integer :: status, ncid
    integer :: dimid_lon, dimid_lat 
    integer :: varid_lon, varid_lat, varid_field
    real, parameter    :: dy = 0.25
    real, parameter    :: dx = 0.25
    integer, parameter :: nc = 360 / dx
    integer, parameter :: nr = 180 / dy
    real, dimension(:), allocatable :: lon_array, lat_array
    real, dimension(:, :), allocatable :: field

    status = nf90_create('data/data.nc', NF90_NETCDF4, ncid)
    call checkStatus(status, 'open')

    call createCoords(dy, dx, nc, nr, lat_array, lon_array, field)
    
    ! add lon dimension 
    status = nf90_def_dim(ncid, 'longitude', nc, dimid_lon)
    call checkStatus(status, 'def lon')
    
    ! add lat dimension
    status = nf90_def_dim(ncid, 'latitude', nr, dimid_lat)
    call checkStatus(status, 'def lat')

    ! define variables
    if ( compress ) then

        status = nf90_def_var(ncid, 'longitude', NF90_FLOAT, &
                                [dimid_lon], varid_lon, &
                                deflate_level=deflate_level)
        call checkStatus(status, 'def var lon')

        status = nf90_def_var(ncid, 'latitude', NF90_FLOAT, &
                                [dimid_lat], varid_lat, &
                                deflate_level=deflate_level)
        call checkStatus(status, 'def var lat')

        status = nf90_def_var(ncid, 'field', NF90_FLOAT, &
                                [dimid_lon, dimid_lat], &
                                varid_field, deflate_level=deflate_level)
        call checkStatus(status, 'def var field')

    else

        status = nf90_def_var(ncid, 'longitude', NF90_FLOAT, [dimid_lon], varid_lon)
        call checkStatus(status, 'def var lon')

        status = nf90_def_var(ncid, 'latitude', NF90_FLOAT, [dimid_lat], varid_lat)
        call checkStatus(status, 'def var lat')

        status = nf90_def_var(ncid, 'field', NF90_FLOAT, [dimid_lon, dimid_lat], &
                                varid_field)
        call checkStatus(status, 'def var field')

    endif
    
    ! add attributes
    status = nf90_put_att(ncid, NF90_GLOBAL, 'note', &
        'training file created with Fortran 90')
    call checkStatus(status, 'put note attr')

    status = nf90_put_att(ncid, varid_lon, 'units', 'degree_east')
    call checkStatus(status, 'put lon units attr')
    
    status = nf90_put_att(ncid, varid_lat, 'units', 'degree_north')
    call checkStatus(status, 'put lat units attr')

    status = nf90_put_att(ncid, varid_field, '_FillValue', -2e8)
    call checkStatus(status, 'put _FillValue attr')

    ! write variables
    status = nf90_put_var(ncid, varid_lon, lon_array)
    call checkStatus(status, 'write lon')

    status = nf90_put_var(ncid, varid_lat, lat_array)
    call checkStatus(status, 'write lat')

    status = nf90_put_var(ncid, varid_field, field)
    call checkStatus(status, 'write field')

    ! close file
    status = nf90_close(ncid)
    call checkStatus(status, 'close')

    ! deallocate arrays
    deallocate(lat_array)
    deallocate(lon_array)
    deallocate(field)
    
    contains

    subroutine createCoords(dy, dx, nc, nr, lat_array, lon_array, field)
        
        implicit none
        
        integer             :: i, j
        integer, parameter  :: pi = 3.14156
        real                :: to_radians = pi / 180.
        real, intent(in)    :: dy, dx
        integer, intent(in) :: nc, nr
        real, dimension(:), allocatable, intent(inout) :: lon_array, lat_array
        real, dimension(:, :), allocatable, intent(inout) :: field
        
        allocate(lon_array(0:nc - 1))
        allocate(lat_array(0:nr - 1))
        allocate(field(0:nc - 1, 0:nr - 1))

        ! lon loop
        do i = 0, nc - 1

            lon_array(i) = (i * dx - 180) + dx / 2
            
            ! lat loop
            do j = 0, nr - 1
                
                lat_array(j) = (j * dy - 90) + dy / 2

                ! create field value
                field(i, j) = sin(lon_array(i) * to_radians) * &
                    cos(lat_array(j) * to_radians)
            
            end do
        end do

    end subroutine createCoords

end program write_netcdf
