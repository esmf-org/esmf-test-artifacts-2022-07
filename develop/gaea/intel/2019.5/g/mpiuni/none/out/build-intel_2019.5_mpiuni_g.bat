Thu Jun 9 00:42:23 EDT 2022
#!/bin/sh -l
#SBATCH --account=nggps_emc
#SBATCH -o build-intel_2019.5_mpiuni_g.bat_%j.o
#SBATCH -e build-intel_2019.5_mpiuni_g.bat_%j.e
#SBATCH --time=1:00:00
#SBATCH --cluster=c4
#SBATCH --qos=normal
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --exclusive
export JOBID=$SLURM_JOBID

module load git/2.26.0
module load intel/19.0.5.281  cray-netcdf/4.6.3.2
module list >& module-build.log

set -x
export ESMF_NETCDF=nc-config

export LIBRARY_PATH=/sw/gaea-cle7/uasw/ncrc/envs/20200417/opt/linux-sles15-x86_64/gcc-7.5.0/globus-toolkit-6.0.17-klqyvmmhxqsf77ita7vvlw3wgyire7df/lib:/opt/intel/compilers_and_libraries_2019.5.281/linux/mpi/intel64/libfabric/lib:/opt/intel/compilers_and_libraries_2019.5.281/linux/ipp/lib/intel64:/opt/intel/compilers_and_libraries_2019.5.281/linux/compiler/lib/intel64_lin:/opt/intel/compilers_and_libraries_2019.5.281/linux/mkl/lib/intel64_lin:/opt/intel/compilers_and_libraries_2019.5.281/linux/tbb/lib/intel64/gcc4.7:/opt/intel/compilers_and_libraries_2019.5.281/linux/tbb/lib/intel64/gcc4.7:/opt/intel/compilers_and_libraries_2019.5.281/linux/daal/lib/intel64_lin:/opt/cray/pe/atp/2.1.3/libApp:/opt/cray/ugni/6.0.14.0-7.0.2.1_3.15__ge78e5b0.ari/lib64:/opt/cray/pe/pmi/5.0.15/lib64:/opt/cray/alps/6.6.59-7.0.2.1_3.7__g872a8d62.ari/lib64:/opt/cray/wlm_detect/1.3.3-7.0.2.1_2.6__g7109084.ari/lib64:/opt/cray/xpmem/2.2.20-7.0.2.1_2.15__g87eb960.ari/lib64:/opt/cray/udreg/2.3.2-7.0.2.1_2.15__g8175d3d.ari/lib64
export ESMF_NETCDF_LIBS="-lnetcdff -lnetcdf"
export ESMF_DIR=/lustre/f2/dev/ncep/Mark.Potts/intel_2019.5_mpiuni_g_develop
export ESMF_COMPILER=intel
export ESMF_COMM=mpiuni
export ESMF_BOPT='g'
export ESMF_TESTEXHAUSTIVE='ON'
export ESMF_TESTWITHTHREADS='ON'
make -j 24 2>&1| tee build_$JOBID.log

