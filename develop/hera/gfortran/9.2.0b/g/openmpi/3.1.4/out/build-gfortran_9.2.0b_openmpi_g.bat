Thu Jun 9 06:55:01 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o build-gfortran_9.2.0b_openmpi_g.bat_%j.o
#SBATCH -e build-gfortran_9.2.0b_openmpi_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
export ESMF_MPIRUN=mpirun.srun
module load gnu/9.2.0 openmpi/3.1.4 

module list >& module-build.log

set -x

tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/gfortran_9.2.0b_openmpi_g_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 2>&1| tee build_$JOBID.log

