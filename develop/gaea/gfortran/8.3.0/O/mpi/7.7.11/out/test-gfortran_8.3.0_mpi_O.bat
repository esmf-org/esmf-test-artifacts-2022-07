Thu Jun 23 01:51:48 EDT 2022
#!/bin/sh -l
#SBATCH --account=nggps_emc
#SBATCH -o test-gfortran_8.3.0_mpi_O.bat_%j.o
#SBATCH -e test-gfortran_8.3.0_mpi_O.bat_%j.e
#SBATCH --time=3:00:00
#SBATCH --cluster=c4
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module unload PrgEnv-intel

module load PrgEnv-gnu git/2.26.0
module load gcc/8.3.0 cray-mpich/7.7.11 cray-netcdf/4.6.3.2
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf"
export ESMF_DIR=/lustre/f2/dev/ncep/Mark.Potts/gfortran_8.3.0_mpi_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpi
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

