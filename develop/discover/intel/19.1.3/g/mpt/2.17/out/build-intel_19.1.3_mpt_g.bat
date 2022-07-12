Tue Jul 12 01:19:41 EDT 2022
#!/bin/sh -l
#SBATCH --account=s2326
#SBATCH -o build-intel_19.1.3_mpt_g.bat_%j.o
#SBATCH -e build-intel_19.1.3_mpt_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --partition=compute
#SBATCH --qos=allnccs
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=28
#SBATCH --exclusive
export JOBID=$SLURM_JOBID
export MPICXX_CXX=icpc
export MPICC_CC=icc
module load comp/intel/19.1.3.304 mpi/sgi-mpt/2.17 netcdf4/4.7.4
module load hdf5/1.13.0 
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export ESMF_NETCDF_LIBS="-lhdf5_hl -lhdf5"
export ESMF_DIR=/gpfsm/dnb04/projects/p98/mpotts/esmf/intel_19.1.3_mpt_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mpt
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 28 2>&1| tee build_$JOBID.log

