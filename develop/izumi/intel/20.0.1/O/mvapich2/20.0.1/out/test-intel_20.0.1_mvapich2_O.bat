Thu Jun 16 16:40:30 MDT 2022
#!/bin/sh -l
#PBS -N test-intel_20.0.1_mvapich2_O.bat
#PBS -l walltime=3:00:00
#PBS -q medium
#PBS -A UNUSED
#PBS -l nodes=1:ppn=48
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /scratch/cluster/dunlap/esmf-testing/intel_20.0.1_mvapich2_O_develop
module load compiler/intel/20.0.1 mpi/2.3.3/intel/20.0.1 tool/netcdf/4.7.4/intel/20.0.1
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/scratch/cluster/dunlap/esmf-testing/intel_20.0.1_mvapich2_O_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mvapich2
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

