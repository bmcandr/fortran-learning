add_executable(${TARGET} write_netcdf.f90)
target_link_libraries (${TARGET} LINK_PUBLIC UTILS)