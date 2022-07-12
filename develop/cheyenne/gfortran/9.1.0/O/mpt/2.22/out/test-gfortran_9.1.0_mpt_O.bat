Tue Jul 12 02:51:59 MDT 2022
#!/bin/sh -l
#PBS -N test-gfortran_9.1.0_mpt_O.bat
#PBS -l walltime=2:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/dunlap/esmf-testing/gfortran_9.1.0_mpt_O_develop

module load cmake
module load gnu/9.1.0 mpt/2.22 netcdf/4.7.3
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_F90COMPILER=mpif90
export ESMF_DIR=/glade/scratch/dunlap/esmf-testing/gfortran_9.1.0_mpt_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpt
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

