Mon Jul 18 06:25:07 UTC 2022
#!/bin/sh -l
#SBATCH --account=nems
#SBATCH -o build-intel_18.0.5a_mpiuni_O.bat_%j.o
#SBATCH -e build-intel_18.0.5a_mpiuni_O.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=hera
#SBATCH --qos=batch
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=40
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load cmake
module load intel/18.0.5.274  netcdf/4.6.1
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/scratch1/NCEPDEV/stmp2/role.esmfmaint/intel_18.0.5a_mpiuni_O_feature_named-alias
export ESMF_COMPILER=intel
export ESMF_COMM=mpiuni
export ESMF_BOPT='O'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 40 2>&1| tee build_$JOBID.log

