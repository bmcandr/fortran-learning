cmake_minimum_required(VERSION 3.19.6)

project(write_netcdf VERSION 0.1
                     DESCRIPTION "Writes a simple netCDF file."
                     LANGUAGES Fortran)

enable_language(Fortran)

set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake" ${CMAKE_MODULE_PATH})

find_package(NetCDF REQUIRED)

set(CMAKE_Fortran_FLAGS "${CMAKE_Fortran_FLAGS} -lnetcdf -lnetcdff")
set(CMAKE_Fortran_MODULE_DIRECTORY ${CMAKE_BINARY_DIR}/modules)

include_directories( /usr/local/include )
link_directories( /usr/local/lib )

set(TARGET write_netcdf)
# set(SOURCE_FILES apps/write_netcdf.f90)

add_subdirectory(src)
add_subdirectory(apps)
