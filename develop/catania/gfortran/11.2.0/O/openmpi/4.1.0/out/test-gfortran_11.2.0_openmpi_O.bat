Thu Jun 16 12:32:33 MDT 2022
#!/bin/bash -l
export JOBID=12346

module use /project/esmf/stack/modulefiles/compilers
module load gcc/11.2.0 openmpi/4.1.0 netcdf/4.7.4
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF=nc-config
export ESMF_MPILAUNCHOPTIONS=--oversubscribe
export ESMF_DIR=/Volumes/esmf/rocky/esmf-testing/gfortran_11.2.0_openmpi_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
chmod +x runpython.sh
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 

