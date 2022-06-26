Sun Jun 26 07:34:06 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o test-pgi_19.1_mpiuni_g.bat_%j.o
#SBATCH -e test-pgi_19.1_mpiuni_g.bat_%j.e
#SBATCH --time=4:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
module load pgi/19.10  

module list >& module-test.log

set -x

export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/pgi_19.1_mpiuni_g_develop
export ESMF_COMPILER=pgi
export ESMF_COMM=mpiuni
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

