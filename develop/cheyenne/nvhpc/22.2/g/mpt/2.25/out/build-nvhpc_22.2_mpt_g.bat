Sun Jun 26 02:44:55 MDT 2022
#!/bin/sh -l
#PBS -N build-nvhpc_22.2_mpt_g.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=3:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpt_g_develop

module load python cmake
module load nvhpc/22.2 mpt/2.25 netcdf/4.8.1
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpt_g_develop
export ESMF_COMPILER=nvhpc
export ESMF_COMM=mpt
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 36 2>&1| tee build_$JOBID.log

