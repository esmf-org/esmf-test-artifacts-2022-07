Thu Jun 16 13:31:44 MDT 2022
#!/bin/bash -l
export JOBID=12345

module use /project/esmf/stack/modulefiles/compilers
module load gcc/11.2.0 openmpi/4.1.0 netcdf/4.7.4
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF=nc-config
export ESMF_MPILAUNCHOPTIONS=--oversubscribe
export ESMF_DIR=/Volumes/esmf/rocky/esmf-testing/gfortran_11.2.0_openmpi_g_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 4 2>&1| tee build_$JOBID.log

