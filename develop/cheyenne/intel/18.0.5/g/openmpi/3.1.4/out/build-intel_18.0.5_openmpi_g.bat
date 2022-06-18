Sat Jun 18 02:54:52 MDT 2022
#!/bin/sh -l
#PBS -N build-intel_18.0.5_openmpi_g.bat
#PBS -l walltime=2:00:00
#PBS -l walltime=3:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/dunlap/esmf-testing/intel_18.0.5_openmpi_g_develop

module load python cmake
module load intel/18.0.5 openmpi/3.1.4 netcdf/4.6.3
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/dunlap/esmf-testing/intel_18.0.5_openmpi_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=openmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 36 2>&1| tee build_$JOBID.log

