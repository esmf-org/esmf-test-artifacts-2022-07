Sun Jul 10 06:21:17 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o build-gfortran_9.2.0a_mpiuni_O.bat_%j.o
#SBATCH -e build-gfortran_9.2.0a_mpiuni_O.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
export ESMF_MPIRUN=/scratch1/NCEPDEV/stmp2/role.esmfmaint/gfortran_9.2.0a_mpiuni_O_develop/src/Infrastructure/stubs/mpiuni/mpirun
module load gnu/9.2.0  netcdf/4.7.2
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/gfortran_9.2.0a_mpiuni_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=mpiuni
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 2>&1| tee build_$JOBID.log

