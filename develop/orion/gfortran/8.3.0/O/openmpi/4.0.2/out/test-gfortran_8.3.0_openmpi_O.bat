Sat Jul 16 03:39:46 CDT 2022
#!/bin/sh -l
#SBATCH --account=da-cpu
#SBATCH -o test-gfortran_8.3.0_openmpi_O.bat_%j.o
#SBATCH -e test-gfortran_8.3.0_openmpi_O.bat_%j.e
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
module load gcc/8.3.0 openmpi/4.0.2 netcdf/4.7.4
module list >& module-test.log

set -x
export ESMF_NETCDF=nc-config

export LD_PRELOAD=/apps/gcc-8/gcc-8.3.0/lib64/libstdc++.so
tar xvfz ~/pytest-input.tar.gz
export ESMF_DIR=/work/noaa/da/mpotts/sandbox/gfortran_8.3.0_openmpi_O_develop
export ESMF_COMPILER=gfortran
export ESMF_COMM=openmpi
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


cd ../src/addon/ESMPy

export PATH=$PATH:$HOME/.local/bin
python3 setup.py build 2>&1 | tee python_build.log
ssh Orion-login-1.HPC.MsState.Edu /work/noaa/da/mpotts/sandbox/gfortran_8.3.0_openmpi_O_develop/runpython.sh 2>&1 | tee python_build.log
python3 setup.py test 2>&1 | tee python_test.log
python3 setup.py test_examples 2>&1 | tee python_examples.log
python3 setup.py test_regrid_from_file 2>&1 | tee python_regrid.log
