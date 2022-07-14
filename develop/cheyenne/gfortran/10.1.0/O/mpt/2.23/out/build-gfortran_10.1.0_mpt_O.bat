Thu Jul 14 02:24:36 MDT 2022
#!/bin/sh -l
#PBS -N build-gfortran_10.1.0_mpt_O.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=2:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/dunlap/esmf-testing/gfortran_10.1.0_mpt_O_develop

module load cmake
module load gnu/10.1.0 mpt/2.23 netcdf/4.7.4
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_F90COMPILER=mpif90
export ESMF_DIR=/glade/scratch/dunlap/esmf-testing/gfortran_10.1.0_mpt_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpt
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 36 2>&1| tee build_$JOBID.log

