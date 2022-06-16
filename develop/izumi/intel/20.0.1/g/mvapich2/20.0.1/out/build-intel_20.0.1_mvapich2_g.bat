Thu Jun 16 13:01:20 MDT 2022
#!/bin/sh -l
#PBS -N build-intel_20.0.1_mvapich2_g.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=2:00:00
#PBS -q medium
#PBS -A UNUSED
#PBS -l nodes=1:ppn=48
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /scratch/cluster/dunlap/esmf-testing/intel_20.0.1_mvapich2_g_develop
module load compiler/intel/20.0.1 mpi/2.3.3/intel/20.0.1 tool/netcdf/4.7.4/intel/20.0.1
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch/cluster/dunlap/esmf-testing/intel_20.0.1_mvapich2_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mvapich2
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 48 2>&1| tee build_$JOBID.log

