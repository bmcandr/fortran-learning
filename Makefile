TARGET=write_netcdf

FFLAGS=/usr/local/include
LDFLAGS=/usr/local/lib

$(TARGET) : write_netcdf.f90 check_mod.o
	gfortran -fcheck=bounds $? -o $@ -I$(FFLAGS) -L$(LDFLAGS) -lnetcdf -lnetcdff

check_mod.o : check_mod.f90
	gfortran -c $? -o $@ -I$(FFLAGS) -L$(LDFLAGS)

clean:
	rm *.o *.mod $(TARGET)


