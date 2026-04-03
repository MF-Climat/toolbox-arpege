#!/usr/bin/bash
#
#
# Script written to run a TL48/TL127 of ARPEGE for debug
# It should be able to run on team servers, it is light and quick
# Inspired from RAPS2024 scripts by R. El Khatib
# Author : G. Dayon
# Date : 03/2024
#        02/2025 : strong revision of the design
# 

# x86 hpc
#SBATCH -p normal256
#SBATCH --mem=247000
#SBATCH --nodes=1
#SBATCH --time=00:10:00
#SBATCH --export=NONE
#SBATCH --exclusiv

module load gcc/14.1.0
module load intel/oneapi/2023.2 mkl/2023.2.0
OASIS_LIBDIR=/home/gmgec/mrgc/dayong/apps/oasis-mct_5.0_7a92be0/lib
export LD_LIBRARY_PATH=$OASIS_LIBDIR:$LD_LIBRARY_PATH
set -x

###########################################
########## Config setup
# Set the model and choose its resolution :
MODEL=arpege
GRID=tl127

# Set the arpege version boundary and initial conditions :
CY=cy49t1
SUBVERSION=03
LEVELS=91
INIT=19790101

# Pack containing the executable of the model :
PACK=/scratch/climat/packs/CY49T1_clim1.03.IMPIIFC2302DP.y

# XIOS server excecutable for the IO server :
LXIOS=0 # Main switch for XIOS : 0=OFF, 1=ON
XIOS3=/scratch/climat/APPS/xios/XIOS-2730--prod-intel2302oasis5-42cd5fee--oasistrunk-fcmold/bin/xios_server.exe

# Model executable :
MASTER=$THISPACK_MDL/bin/MASTERODB

# Some verbosity and options
VERBOSE=false 	# Print namelist and output
REPROD=false	# Control reproductibility by norms comparison
HOOK=false	# Activate Hook profiling
SAVE=false	# Saving output files in $OUTDIR
CLEAN=false	# Clean temporary directory !! Warning if false you MUST do it manually

###########################################
########## Computing setup
# Set the number of nodes, tasks per node and threads per task for the model :
NNODE_FC=1
NTASK_FC=124
NOPMP_FC=1
# Set the total number of MPI tasks for the model :
NPROC_FC=$((NNODE_FC*NTASK_FC))

# Set the number of nodes, tasks per node and threads per task for the XIOS server :
NNODE_XIOS=1
NTASK_XIOS=4
# Set the total number of MPI tasks for the I/O server :
NPROC_XIOS=$((NNODE_XIOS*NTASK_XIOS))
if [ $LXIOS -eq 0 ]; then NPROC_XIOS=0; fi

###########################################
########## Script configuration
# Namelists
NAMDIR=~/toolbox-arpege/namelist
NAMATM=$NAMDIR/atm/nam.atm.tl127l91r.cy49t1_clim1.03
NAMSFX=$NAMDIR/sfx/nam.sfx.tl127r.cy49t1_clim1.03
NAMIOS=$NAMDIR/ios
if [ $LXIOS -eq 0 ]; then NAMSFX=${NAMSFX}_noxios; fi

# Restarts
RESDIR=/scratch/climat/daac-dev/restart
RESATM=$RESDIR/atm/ICMSH0123INIT.tl127l91r.cy49t1_clim1.03.19790101.fa
RESSFX=$RESDIR/sfx/ICMSH0123INIT.sfx.tl127r.cy49t1_clim1.03.19790101.fa

# Resolution dependant dataset
CLIMATM=$RESDIR/atm/Const.Clim.tl127l91r.cy49t1_clim1.03
CLIMO3=$RESDIR/atm/Const.Clim.O3.tl127l91r.cy49t1_clim1.03
PGDSFX=$RESDIR/sfx/Const.Clim.sfx.tl127r.cy49t1_clim1.03.fa

# Arpege options
STOP=24 # forecast range expressed in hours
NPRINTLEV=1 # listing verbosity (1 is verbose)

# XIOS options
XIOS_VERBOSE=false # print log files (logical)
XIOS_VERBOSITY=10 # level of verbosity (0-100)

# root directory of this benchmark :
TOY=~/toolbox-arpege/toy
# PATH to various tools provided and used in this benchmark :
export PATH=$TOY/tools:$PATH
# Reference NODE file
REFPROF=$TOY/refprof/NODE.001_01.${GRID}r.128cpus.16proma.ref

# root directory of input datasets (constants) of this benchmark :
DATADIR=/scratch/climat/daac-dev/data

# directory for the outputs (profile, NODE and xios output):
ROOT_OUTDIR=/scratch/work/${USER}/output
DATE=`date +%y%m%d%H%M`
OUTDIR=$ROOT_OUTDIR/${MODEL}.${GRID}.${CY}.${SUBVERSION}.${DATE}
mkdir -p $OUTDIR
rm $OUTDIR/*.nc

###########################################
########## Environment variables
# DrHook internal profiler :
export DR_HOOK=1
export DR_HOOK_IGNORE_SIGNALS=-1
export DR_HOOK_SILENT=1
export DR_HOOK_SHOW_PROCESS_OPTIONS=0
export DR_HOOK_OPT=prof
# For timing, disable DrHook as follows :
if ! $HOOK ; then
   export DR_HOOK=0
   unset DR_HOOK_OPT
fi

# Arpege/Arome-specific :
export MPL_MBX_SIZE=2048000000
export EC_PROFILE_HEAP=0
export EC_PROFILE_MEM=0
export EC_MPI_ATEXIT=0
export EC_MEMINFO=0

# EcCodes definition
export ECCODES_SAMPLES_PATH=/home/gmap/mrpe/mary/public/ecCodes/2.38.1/share/eccodes/ifs_samples/grib1_mlgrib2
export ECCODES_DEFINITION_PATH=/home/gmap/mrpe/mary/public/ecCodes/2.38.1/share/eccodes/definitions

# XIOS 3 specific :
export ARPIFS_USE_XIOS=1
export ARPIFS_XIOS_INVERT_LEVELS=1
if [ $LXIOS -eq 0 ]; then ARPIFS_USE_XIOS=0; fi

# MKL reproducibility
export MKL_CBWR="AUTO,STRICT"

# Others :
export OMP_STACKSIZE=4G
export KMP_STACKSIZE=4G
export KMP_MONITOR_STACKSIZE=4G
export OMP_NUM_THREADS=$NOPMP_FC

# CPU binding
export SLURM_CPU_BIND=none

# Usually needed for Open-MP support or large stack management :
ulimit -s unlimited
ulimit -c 0 # Not if it's necessary

###########################################
########## Prepare the run
# Change to a temporary directory :
if [ ! "$TMPDIR" ] ; then
  TMPDIR=$(mktemp -u)
fi
mkdir -p $TMPDIR
cd $TMPDIR

# Copy the restart
cp $RESATM ICMSH0123INIT
cp $RESSFX ICMSH0123INIT.sfx

# Get constant data for Arpege
cp $CLIMATM Const.Clim
cp $CLIMO3 Const.Clim.O3

# Get constant data for Surfex
cp $PGDSFX Const.Clim.sfx 
cp $DATADIR/surfex/ecoclimap* .

# ECRad
cp $DATADIR/ecrad/RADSRTM .
cp $DATADIR/ecrad/RADRRTM .
cp $DATADIR/ecrad/greenhouse_gas_climatology_48r1.nc .
cp $DATADIR/ecrad/greenhouse_gas_timeseries_CMIP3_A1B_46r1.nc .
cp $DATADIR/ecrad/slingo_droplet_scattering_rrtm.nc .
cp $DATADIR/ecrad/fu_ice_scattering_rrtm.nc .
cp $DATADIR/ecrad/aerosol_CNRM-CM6.nc .
cp $DATADIR/ecrad/mcica_gamma.nc .

# Unknown
cp $DATADIR/ECOZC .

# Copy the namelists
cp $NAMATM fort.4
cp $NAMSFX EXSEG1.nam
cp $NAMIOS/* .

# Modify some key variables in namelists
sed -i "s/NPROC=AUTO/NPROC=$NPROC_FC/g" fort.4
sed -i "s/NSTRIN=AUTO/NSTRIN=$NPROC_FC/g" fort.4
sed -i "s/NSTROUT=AUTO/NSTROUT=$NPROC_FC/g" fort.4
sed -i "s/CSTOP=AUTO/CSTOP='h$STOP'/g" fort.4
sed -i "s/NPRINTLEV=AUTO/NPRINTLEV=$NPRINTLEV/g" fort.4

sed -i "s|@OUTDIR|$OUTDIR|g" arpsfx_files.xml
sed -i "s/@OUTNAME/${MODEL}_${CY}.${SUBVERSION}_${GRID}/g" arpsfx_files.xml
sed -i "s/@PRINTFILE/$XIOS_VERBOSE/g" iodef.xml
sed -i "s/@INFOLEVEL/$XIOS_VERBOSITY/g" iodef.xml

# print the final namelists :
if $VERBOSE; then
   echo 'ARPEGE namelist'
   cat fort.4

   echo 'SURFEX namelist'
   cat EXSEG1.nam
   
   ls -lrti
fi

###########################################
########## Run the model
# Model executable :
MASTER=$PACK/bin/MASTERODB

# Run :
pwd
RUNNER=/opt/softs/intel/oneapi/2023.2/mpi/2021.10.0/bin/mpiexec.hydra
source /opt/softs/intel/oneapi/2023.2/mpi/2021.10.0/env/vars.sh


#RUNNER=/opt/softs/intel/oneapi/2023.2/mpi/2021.10.0/bin/mpirun
#RUNNER=/home/gmap/mrpm/marguina/SAVE/mpiauto/mpiauto

if [ $LXIOS -eq 1 ]; then
   $RUNNER  -np $NPROC_XIOS $XIOS3 : -np $((NPROC_FC)) $MASTER
else
   $RUNNER -np $((NPROC_FC)) $MASTER
fi

ls -lrth


###########################################
########## Save the outputs and do some checks
cp * $OUTDIR/.

cp *.err $OUTDIR/.
cp *.out $OUTDIR/.
cp fort.* $OUTDIR/.

# Print out the listing :
if $VERBOSE ; then
   cat NODE.001_01
fi
cp NODE.001_01  $OUTDIR/.

# Check the validity of scientific results :
if $REPROD; then
   diffNODE.001_01 NODE.001_01 $REFPROF > diffNODE.001_01.out
   cp diffNODE.001_01.out $OUTDIR/.
   cat diffNODE.001_01.out
fi

# Print out the merged DrHook profiles, if any
if [ -f drhook.prof.1 ] ; then
  cat drhook.prof.* | drhook_merge_walltime_max > drhook.prof
  cp drhook.prof $OUTDIR/.
  if $VERBOSE; then cat drhook.prof; fi
fi

if $SAVE; then
   cp ICMSH*   $OUTDIR/.
   cp DHF*     $OUTDIR/.
   cp arpege.* $OUTDIR/.
fi

if $CLEAN; then
   rm -r $TMPDIR
fi

echo "You reach the end of the script"
echo "Rundir is here : "$TMPDIR
echo "Outputs are saved here : " $OUTDIR

exit

