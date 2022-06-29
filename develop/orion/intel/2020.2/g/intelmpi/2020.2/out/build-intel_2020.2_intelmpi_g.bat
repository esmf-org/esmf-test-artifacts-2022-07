Wed Jun 29 03:32:16 CDT 2022
#!/bin/sh -l
#SBATCH --account=da-cpu
#SBATCH -o build-intel_2020.2_intelmpi_g.bat_%j.o
#SBATCH -e build-intel_2020.2_intelmpi_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=orion
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load intelpython3 cmake
export ESMF_MPIRUN=mpirun.srun
export ESMPY_MPIRUN=srun
module load intel/2020.2 impi/2020.2 netcdf/4.7.4
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/work/noaa/da/mpotts/sandbox/intel_2020.2_intelmpi_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=intelmpi
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 2>&1| tee build_$JOBID.log

