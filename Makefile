#FFLAGS=`nf-config --fflags`
#LDFLAGS=`nf-config --flibs`

FFLAGS=/usr/local/include
LDFLAGS=/usr/local/lib

write_netcdf : write_netcdf.f90 check_mod.o
	gfortran -fcheck=bounds $? -o $@ -I$(FFLAGS) -L$(LDFLAGS) -lnetcdf -lnetcdff

check_mod.o : check_mod.f90
	gfortran -c $? -o $@ -I$(FFLAGS) -L$(LDFLAGS)

clean:
	rm *.o *.mod write_netcdf


