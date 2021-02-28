TARGET=write_netcdf
FC=gfortran
FFLAGS=/usr/local/include
LDFLAGS=/usr/local/lib
LIBS=-lnetcdf -lnetcdff

$(TARGET) : write_netcdf.f90 check_mod.o
	$(FC) -fcheck=bounds $? -o $@ -I$(FFLAGS) -L$(LDFLAGS) $(LIBS)

check_mod.o : check_mod.f90
	$(FC) -c $? -o $@ -I$(FFLAGS) -L$(LDFLAGS)

clean:
	rm *.o *.mod $(TARGET)
