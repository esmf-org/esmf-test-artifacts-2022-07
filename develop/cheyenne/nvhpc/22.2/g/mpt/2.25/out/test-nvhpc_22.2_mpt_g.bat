Fri Jun 17 02:45:42 MDT 2022
#!/bin/sh -l
#PBS -N test-nvhpc_22.2_mpt_g.bat
#PBS -l walltime=3:00:00
#PBS -q regular
#PBS -A p93300606
#PBS -l select=1:ncpus=36:mpiprocs=36
JOBID="`echo $PBS_JOBID | cut -d. -f1`"

cd /glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpt_g_develop

module load python cmake
module load nvhpc/22.2 mpt/2.25 netcdf/4.8.1
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_DIR=/glade/scratch/dunlap/esmf-testing/nvhpc_22.2_mpt_g_develop
export ESMF_COMPILER=nvhpc
export ESMF_COMM=mpt
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make info 2>&1| tee info.log 
make install 2>&1| tee install_$JOBID.log 
make all_tests 2>&1| tee test_$JOBID.log 
export ESMFMKFILE=`find $PWD/DEFAULTINSTALLDIR -iname esmf.mk`
chmod +x runpython.sh
cd nuopc-app-prototypes
./testProtos.sh 2>&1| tee ../nuopc_$JOBID.log 

