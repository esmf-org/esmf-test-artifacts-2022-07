Thu Jun 16 16:29:54 MDT 2022
#!/bin/sh -l
#PBS -N build-nag_6.2_mvapich2_O.bat
#PBS -l walltime=1:00:00
#PBS -l walltime=3:00:00
#PBS -q medium
#PBS -A UNUSED
#PBS -l nodes=1:ppn=48
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /scratch/cluster/dunlap/esmf-testing/nag_6.2_mvapich2_O_develop
module load compiler/nag/6.2-8.1.0 mpi/2.3.3/nag/6.2 tool/netcdf/c4.6.1-f4.4.4/nag-gnu/6.2-8.1.0
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch/cluster/dunlap/esmf-testing/nag_6.2_mvapich2_O_develop
export ESMF_COMPILER=nag
export ESMF_COMM=mvapich2
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 48 2>&1| tee build_$JOBID.log

