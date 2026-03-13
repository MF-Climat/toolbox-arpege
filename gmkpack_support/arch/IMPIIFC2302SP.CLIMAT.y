
# ARCHITECTURE FILE FOR LINUX PLATFORMS WITH INTEL COMPILER AND INTEL MPI
# =======================================================================

# Libraries environment profile
# -----------------------------

GMK_LOCAL_PROFILE = ~/toolbox-arpege/gmkpack_support/env/env_intel-mpi-2023.2-eccodes2.38.3_mklrepro2023

# Fortran (cross-)compiler
# ------------------------

FRTNAME = ~toolbox-arpege/gmkpack_support/wrapper/mpiifort_wrapper

# C (cross-)compiler
# ------------------

VCCNAME = mpiicc

# C++ (cross-)compiler
# ------------------

CXXNAME = mpiicpc

# Native C compiler
# -----------------

CCNATIVE = icc -diag-disable=10441

# Native C linker flags
# ---------------------

LNK_MPCCNATIVE =

# fypp preprocessor
# -----------------

GMK_FYPP = fypp

# fypp preprocessor background flags
# ----------------------------------

GMK_FYPP_FLAGS = -m os -m yaml

# Fortran compiler default version (stamp)
# ----------------------------------------

LIBFRT = echo IMPIIFC2302SP

# Basic compilation flags
# -----------------------

FRTFLAGS = -c -convert big_endian -assume byterecl -align array64byte,all -traceback -fpic -qopenmp -qopenmp-threadprivate compat -fp-model source -ftz -diag-disable=remark,cpu-dispatch -qopt-report=5 -qopt-report-phase=vec
VCCFLAGS = -c -qopenmp -fpic -malign-double -ftz -fp-model precise -diag-disable=remark,cpu-dispatch -qopt-report=2 -qopt-report-phase=vec -diag-disable=10441
# Option -C in order to create files without compiling inside odb98
# In order to have any effect from the following -1 or -A options,
# -O3 optimization level must be activated.
ODBFLAGS = -C -O3

# Fortran double precision flags
# ------------------------------
DBL_FRTFLAGS = 

# Fortran Cpp + extensions flags
# ------------------------------
F77_CPPFLAG =
F90_CPPFLAG = 
F77_NOCPPFLAG =
F90_NOCPPFLAG = 

# Fortran format flag
# --------------------
FREE_FRTFLAG = -free
FIXED_FRTFLAG = -fixed

# Optimized compilation flag
# --------------------------

OPT_FRTFLAGS = -g -O2 -march=core-avx2 -finline-functions -finline-limit=500 -Winline -qopt-prefetch=4 -fast-transcendentals -fimf-use-svml -no-fma -mcmodel=medium
OPT_VCCFLAGS = -g -O2 -march=core-avx2

# Debugging compilation flag
# --------------------------

DBG_FRTFLAGS = -g -O0

# Bound checking compilation flag
# -------------------------------

BCD_FRTFLAGS = -check bounds

# NaN pre-initialisation flag
# ---------------------------

NAN_FRTFLAGS = -init=arrays,snan -fp-stack-check -ftrapuv -fpe0 -fp-speculation=strict -check uninit -check pointers

# Listing compilation flag
# ------------------------

LIST_FRTFLAGS = -list -show nomap
LIST_VCCFLAGS =

# Filename extension for listing
# ------------------------------

LIST_EXTENSION = lst

# Additive compilation flags
# --------------------------

MACROS_FRT = -DLINUX -DLITTLE_ENDIAN -DLITTLE -DADDRESS64 -DPARKIND1_SINGLE
MACROS_CC = -DLINUX -DLITTLE_ENDIAN -DLITTLE -DPARKIND1_SINGLE
MACROS_CXX = -std=c++11
MACROS_BL95 = -DLINUX -DLITTLE_ENDIAN -DLITTLE -DIS_MAIN_PROG -DSTATIC_LINKING
MACROS_ODB98 = -DLINUX -DLITTLE_ENDIAN -DLITTLE -DXPRIVATE=PRIVATE -UINTERCEPT_ALLOC -UUSE_ALLOCA_H -DWITHOUT_OML

GMK_FCFLAGS_ARPIFS = -DCPLOASIS -DWXIOS

GMK_FCFLAGS_SATRAD = -D_RTTOV_DO_DISTRIBCOEF -D_RTTOV_HDF -DWITHOUT_EMOSLIB

GMK_FCFLAGS_SURFEX = -Din_surfex -DSFX_ARO -DSFX_ASC -DSFX_OL -DSFX_TXT -DSFX_FA -DSFX_LFI -DARO -DOL -DASC -DTXT -DFA -DLFI -DCPLOASIS -DWXIOS -DTOPD
GMK_FCFLAGS_MSE = -DSFX_FA -DCPLOASIS -DWXIOS
GMK_FCFLAGS_MPA =
GMK_FCFLAGS_PHYEX =

GMK_FCFLAGS_IFSAUX = -DHIGHRES -DBLAS
GMK_FCFLAGS_ALGOR = -DBLAS
GMK_CFLAGS_IFSAUX = -DPOINTER_64
GMK_CFLAGS_ODB = -DSTATIC_LINKING -DXPRIVATE=PRIVATE -DINTERCEPT_ALLOC -DUSE_ALLOCA_H -DCANARI -DHAS_LAPACK -DNO_CURSES -DODB_NMXUPD=4
GMK_CFLAGS_BLACKLIST = -DSTATIC_LINKING -DXPRIVATE=PRIVATE -DINTERCEPT_ALLOC -DUSE_ALLOCA_H

GMK_FCFLAGS_TRANS = -DWITH_FFTW
GMK_FCFLAGS_ETRANS = -DWITH_FFTW

# Fortran (cross-)linker
# ----------------------

LNK_STD = ifort

# Message Passing Fortran (cross-)linker
# --------------------------------------

LNK_MPI = ~/toolbox-arpege/gmkpack_support/wrapper/mpiifort_wrapper

# Cc (cross-)linker
# -----------------

LNK_CC = icc -qopenmp -shared-intel -lrt -lstdc++

# CXX (cross-)linker (for mixed langages c++ and fortran)
# -------------------------------------------------------

LNK_CXX = mpiicpc

# Fortran linking flags
# ----------------------

LNK_FLAGS = -v -fp-stack-check -qopenmp -qopenmp-threadprivate compat -shared-intel -lrt -lstdc++ -mcmodel=medium 

# Additional linking flags to LNK_FLAGS for c++ executable
# --------------------------------------------------------

LNK_CXX_FLAGS =

# flags for executable targets
# ----------------------------

EXTRA_LNKFLAGS = -liomp5
LNK_EXEC =

# flags for shared object targets
# -------------------------------

LNK_SOLIB = -shared -o a.out

# Fortran Flag for start/end group libraries
# ------------------------------------------

LNK_STARTG = -Wl,--start-group
LNK_ENDG   = -Wl,--end-group

# Flag for linking with whole static libraries
# ---------------------------------  ---------

LNK_WHOLE_ARCHIVE = -Wl,-whole-archive
LNK_NO_WHOLE_ARCHIVE = -Wl,-no-whole-archive

# Flags for static/dynamic linking
# --------------------------------

LNK_STATIC = -Wl,-Bstatic
LNK_DYNAMIC = -Wl,-Bdynamic

# Load map flag
# -------------

LNK_MAP = -Wl,-M

# Hub
# ---
# Hub general directory
GMK_HUB_DIR      = hub
# Hub general installation directory (must be at a fixed place inside the pack in order to be propagated)
GMK_HUB_INSTALL  = install
# Hub general build directory (absolute path because it may be a non-permanent directory in production mode) :
GMK_HUB_BUILD    = \${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMKLOCAL}/build

# List of projects in hub (ordered sort to enable dependencies)
GMK_HUB_PROJECTS = ecSDK OOPS Atlas Fiat Ectrans Field_api

GMK_HUB_LIBRARIES_IN_ecSDK = ecbuild eckit fckit
GMK_HUB_METHOD_FOR_ecSDK = cmake

GMK_HUB_LIBRARIES_IN_OOPS = oops_src
GMK_HUB_METHOD_FOR_OOPS = cmake

GMK_HUB_LIBRARIES_IN_Atlas = atlas
GMK_HUB_METHOD_FOR_Atlas = cmake

GMK_HUB_LIBRARIES_IN_Fiat = fiat
GMK_HUB_METHOD_FOR_Fiat = cmake

GMK_HUB_LIBRARIES_IN_Ectrans = ectrans
GMK_HUB_METHOD_FOR_Ectrans = cmake

GMK_HUB_LIBRARIES_IN_Field_api = field_api
GMK_HUB_METHOD_FOR_Field_api = cmake

GMK_CMAKE_ecbuild = -Wno-deprecated -Wno-dev -DCMAKE_C_COMPILER=\${VCCNAME}

GMK_CMAKE_eckit = -Wno-deprecated -Wno-dev -DCMAKE_C_COMPILER=\${VCCNAME} -DCMAKE_C_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS}\" -DCMAKE_CXX_COMPILER=\${CXXNAME} -DCMAKE_CXX_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS} ${MACROS_CXX}\" -DCMAKE_BUILD_TYPE=NONE -DENABLE_ECKIT_CMD=OFF -DENABLE_ECKIT_SQL=OFF -DENABLE_BZIP2=OFF -DENABLE_SNAPPY=OFF -DENABLE_LAPACK=OFF -DENABLE_CURL=OFF -DENABLE_DOCS=OFF -DENABLE_SSL=OFF -DBUILD_SHARED_LIBS=BOTH -DECBUILD_2_COMPAT=ON -DECBUILD_2_COMPAT_DEPRECATE=OFF

GMK_CMAKE_fckit = -Wno-deprecated -Wno-dev -DCMAKE_CXX_COMPILER=\${CXXNAME} -DCMAKE_CXX_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS} ${MACROS_CXX}\" -DCMAKE_Fortran_COMPILER=\${FRTNAME} -DCMAKE_Fortran_FLAGS=\"${FRTFLAGS} ${OPT_FRTFLAGS}\" -DCMAKE_BUILD_TYPE=NONE -DCMAKE_PREFIX_PATH=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMK_HUB_INSTALL}/ecSDK -DENABLE_FINAL=OFF -DENABLE_TESTS=ON -DBUILD_SHARED_LIBS=OFF -DECBUILD_2_COMPAT=ON -DECBUILD_2_COMPAT_DEPRECATE=OFF

GMK_CMAKE_oops_src = -Wno-deprecated -Wno-dev -DCMAKE_C_COMPILER=\${VCCNAME} -DCMAKE_C_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS}\" -DCMAKE_CXX_COMPILER=\${CXXNAME} -DCMAKE_CXX_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS} ${MACROS_CXX}\" -DCMAKE_Fortran_COMPILER=\${FRTNAME} -DCMAKE_Fortran_FLAGS=\"${FRTFLAGS} ${OPT_FRTFLAGS}\" -DCMAKE_BUILD_TYPE=NONE -Decbuild_ROOT=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMKSRC}/ecSDK -DECKIT_PATH=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMK_HUB_INSTALL}/ecSDK -DFCKIT_PATH=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMK_HUB_INSTALL}/ecSDK -DEIGEN3_INCLUDE_DIR=/home/gmap/mrpm/khatib/opt/eigen-3.3.7 -DENABLE_TESTS=ON -DBUILD_SHARED_LIBS=BOTH -DECBUILD_2_COMPAT=ON -DECBUILD_2_COMPAT_DEPRECATE=OFF

GMK_CMAKE_atlas = -Wno-deprecated -Wno-dev -DCMAKE_C_COMPILER=\${VCCNAME} -DCMAKE_C_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS}\" -DCMAKE_CXX_COMPILER=\${CXXNAME} -DCMAKE_CXX_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS} ${MACROS_CXX}\" -DCMAKE_Fortran_COMPILER=\${FRTNAME} -DATLAS_Fortran_FLAGS=\"${FRTFLAGS} ${OPT_FRTFLAGS}\" -DCMAKE_BUILD_TYPE=NONE -Decbuild_ROOT=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMKSRC}/ecSDK -DCMAKE_PREFIX_PATH=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMK_HUB_INSTALL}/ecSDK -DENABLE_TESTS=ON -DBUILD_SHARED_LIBS=OFF -DECBUILD_2_COMPAT=ON -DECBUILD_2_COMPAT_DEPRECATE=OFF

GMK_CMAKE_fiat = -Wno-deprecated -Wno-dev -DCMAKE_C_COMPILER=\${VCCNAME} -DCMAKE_C_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS} ${MACROS_CC}\" -DCMAKE_CXX_COMPILER=\${CXXNAME} -DCMAKE_CXX_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS} ${MACROS_CXX}\" -DCMAKE_Fortran_COMPILER=\${FRTNAME} -DCMAKE_Fortran_FLAGS=\"${FRTFLAGS} ${OPT_FRTFLAGS} ${MACROS_FRT}\" -DCMAKE_BUILD_TYPE=NONE -Decbuild_ROOT=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMKSRC}/ecSDK -DBUILD_SHARED_LIBS=BOTH -DENABLE_TESTS=ON -DECBUILD_2_COMPAT=ON -DECBUILD_2_COMPAT_DEPRECATE=OFF -DENABLE_DOUBLE_PRECISION=OFF -DENABLE_DUMMY_MPI_HEADER=OFF

GMK_CMAKE_ectrans = -Wno-deprecated -Wno-dev -DCMAKE_C_COMPILER=\${VCCNAME} -DCMAKE_C_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS}\" -DCMAKE_CXX_COMPILER=\${CXXNAME} -DCMAKE_CXX_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS} ${MACROS_CXX}\" -DCMAKE_Fortran_COMPILER=\${FRTNAME} -DCMAKE_Fortran_FLAGS=\"${FRTFLAGS} ${OPT_FRTFLAGS} ${MACROS_FRT}\" -DCMAKE_BUILD_TYPE=NONE -Decbuild_ROOT=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMKSRC}/ecSDK -Dfiat_ROOT=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMK_HUB_INSTALL}/Fiat -DENABLE_TRANSI=OFF -DBUILD_SHARED_LIBS=OFF -DENABLE_TESTS=ON -DECBUILD_2_COMPAT=ON -DECBUILD_2_COMPAT_DEPRECATE=OFF -DENABLE_DOUBLE_PRECISION=OFF -DMKL_PATH=\$MKLROOT/mkl -DENABLE_GPU=OFF -Deccodes_ROOT=\${ECCODES_INSTALLDIR}

GMK_CMAKE_field_api = -Wno-deprecated -Wno-dev -DCMAKE_C_COMPILER=\${VCCNAME} -DCMAKE_C_FLAGS=\"${VCCFLAGS} ${OPT_VCCFLAGS}\" -DCMAKE_Fortran_COMPILER=\${FRTNAME} -DCMAKE_Fortran_FLAGS=\"${FRTFLAGS} ${OPT_FRTFLAGS} ${MACROS_FRT}\" -DCMAKE_BUILD_TYPE=NONE -Decbuild_ROOT=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMKSRC}/ecSDK -Dfiat_ROOT=\${TARGET_PACK}/\${GMK_HUB_DIR}/\${GMK_LAST_HUB_BRANCH}/\${GMK_HUB_INSTALL}/Fiat -DBUILD_SHARED_LIBS=OFF -DENABLE_ACC=OFF -DENABLE_DOUBLE_PRECISION=OFF

# User libraries (absolute filename or short name) :
# ------------------------------------------------

# "Read Grib from BDAP":
LD_USR01 = rgb
# "Bufr decoding":
LD_USR02 = bufr
# "ec":
LD_USR03 =
# "Gribex (or emos)":
LD_USR04 = gribex
# "ecmwf field database":
LD_USR05 = fdbdummy
# "ecmwf wave model":
LD_USR06 = wamdummy
# "C code generated by blacklist":
LD_USR07 =
# "Nag":
LD_USR08 = naglitedummy
# "OASIS":
LD_USR09 =
# "Grib_api":
LD_USR_GRIB_API_F90 = eccodes_f90
LD_USR_GRIB_API = eccodes
# "JPEG library":
LD_USR_JPEG =
# "EECFI" for aeolus:
LD_USR_EECFI =
# "Netcdf :"
LD_USR_NETCDF_F = netcdff
LD_USR_NETCDF = netcdf
# "HDF5" :
LD_USR_HDF5_HLFORTRAN = hdf5hl_fortran
LD_USR_HDF5_FORTRAN = hdf5_fortran
LD_USR_HDF5 = hdf5
# "Meteo-France dummies library (IFS only):"
LD_USR_MF_DUMMY =
# "Magics :"
LD_USR_MAGICS =
# "xml :"
LD_USR_XML = 
# "Boost unit test framework" :
LD_USR_BOOST_UNIT_TEST_FRAMEWORK = boost_unit_test_framework

# Libraries from Hub :
# "eckit/fckit":
LD_USR_FCKIT = 
LD_USR_ECKIT_MPI = 
LD_USR_ECKIT = 
# "OOPS" :
LD_USR_OOPS = oops
# "OOPS-neural" :
LD_USR_OOPS_NEURAL = neural
# "Atlas" :
LD_USR_ATLAS_F = 
# parkind :
LD_USR_PARKIND = parkind_sp
# fiat :
LD_USR_FIAT = fiat
# mpi_serial :
LD_USR_MPI_SERIAL = mpi_serial
# ectrans :
LD_USR_ECTRANS = trans_sp
# field_api :
LD_USR_FIELD_API = field_api_sp

# Language libraries (absolute filename or short name) :
# ----------------------------------------------------

# Lapack:
LD_LANG01 = 
# Blas:
LD_LANG02 =

# System-dependent libraries - ALWAYS LOADED - (absolute filename or short name) :
# ------------------------------------------------------------------------------

LD_SYS01 = /scratch/climat/APPS/xios/XIOS-2730--prod-intel2302oasis5-42cd5fee--oasistrunk-fcmold/lib/libxios.a 
LD_SYS02 = /opt/softs/gcc/14.1.0/lib64/libstdc++.a
LD_SYS03 = /scratch/climat/APPS/oasis/OASIS3-MCT_5.0_42cd5fee/belenos_intel2302/lib/libpsmile.MPI1.a 
LD_SYS04 = /scratch/climat/APPS/oasis/OASIS3-MCT_5.0_42cd5fee/belenos_intel2302/lib/libmct.a
LD_SYS05 = /scratch/climat/APPS/oasis/OASIS3-MCT_5.0_42cd5fee/belenos_intel2302/lib/libmpeu.a
LD_SYS06 = /scratch/climat/APPS/oasis/OASIS3-MCT_5.0_42cd5fee/belenos_intel2302/lib/libscrip.a
LD_SYS07 = ibmdummy
LD_SYS08 =

# MPI libraries (absolute filename or short name) :
# -----------------------------------------------

LD_MPI01 =
LD_MPI02 =
LD_MPI03 =

LD_MPI_DUMMY =

# Precompiler libraries
# ----------------------

LD_LIBC  =
LD_LIBM  =
LD_LIBVFL =

# External include pathes (path1:path2:...)
# ------------------------------------------

INCLUDEPATH = /scratch/climat/APPS/xios/XIOS-2730--prod-intel2302oasis5-42cd5fee--oasistrunk-fcmold/inc:/scratch/climat/APPS/oasis/OASIS3-MCT_5.0_42cd5fee/belenos_intel2302/include

# (Cross-) nm command & options for BSD format
# --------------------------------------------

NMOPTS = /usr/bin/nm 

# Native awk program
# ------------------

AWK = /bin/awk 

# (Cross-)archive
# ---------------

AR = /usr/bin/ar 

# Native archive
# --------------

ARNATIVE = /usr/bin/ar 

# Native preprocessor
# -------------------

CPP = /usr/bin/cpp 

# cmake executable
# ----------------

GMK_CMAKE = cmake

# Native lex program
# ------------------

LEX = flex -l

# Includes & modules
# ------------------

MODINC = -I
MODEXT = mod

# gget to recover volatile libraries
# ----------------------------------

GGET =

# External script used to generate and pre-process th blacklist file
# ------------------------------------------------------------------

GMK_BL_GENERATOR =

# Epilog of script
# ----------------

EPILOG = echo Finished on \$(date)

# Prefix of user's $(SHELL)rc file
# --------------------------------

GMKUSERFILE = 

# Prefix for root packs
# ---------------------

PACK_PREFIX =

# Suffix for root packs
# ---------------------

PACK_EXT =

# Binaries directory name
# -----------------------

GMKBIN = bin

# Libraries directory name
# ------------------------

GMKLIB = lib

# All-sources directory name
# --------------------------

GMKSRC = src

# Interfaces directory name for each branch
# -----------------------------------------

GMKINTFB = .intfb

# directory of .F90 files generated from .fypp files
# --------------------------------------------------

GMKFYPPF90 = .fypp

# MAIN (ie : bottom background) source directory name
# ---------------------------------------------------

GMKMAIN = main

# INTERMEDIATE (ie : intermediate background) source directory name
# -----------------------------------------------------------------

GMKINTER = inter

# LOCAL (ie : top) source directory name
# --------------------------------------

GMKLOCAL = local

# Unsatisfied external references main directory
# ----------------------------------------------

GMKUNSX = unsxref

# Quiet unsatisfied external references directory
# -----------------------------------------------

GMKUNSX_QUIET = quiet

# Verboose unsatisfied external references directory
# --------------------------------------------------

GMKUNSX_VERBOOSE = verbose

# system-program main directory
# -----------------------------

GMKSYS = sys

# Genesis file name
# -----------------

GMK_GENESIS = .genesis

# View file name
# --------------

GMK_VIEW = .gmkview

# Logfile name
# ------------

GMK_LOG = .logfile

# Scriptfile prefix
# -----------------

GMK_ICS = ics_

# Submission cards : number of nodes
# ----------------------------------

GMK_NQS_NODES = #SBATCH --cpus-per-task=10

# Submission cards : large memory
# -------------------------------

GMK_NQS_LARGE = #SBATCH --mem-per-cpu=2000

# Submission cards : time limit
# -----------------------------

GMK_NQS_TIME  = #SBATCH --time=01:45:00

# Submission cards : output file KEY
# ----------------------------------

GMK_NQS_OUT_P = 

# Submission cards : error file KEY
# ---------------------------------

GMK_NQS_ERR_P = 

# Submission cards : output/error file stamp
# ------------------------------------------

GMK_NQS_JOBID = 

# Submission cards : other directives
# -----------------------------------
 
GMK_NQS_OTHER = #SBATCH --partition=login
GMK_NQS_OTHER = #redefine the temporary directory because in batch mode TMPDIR is set after the .bash_profile is sourced :
GMK_NQS_OTHER = if [ "$SLURM_JOB_PARTITION" ] ; then export GMKTMP=/dev/shm/$LOGNAME/slurm ; fi
GMK_NQS_OTHER = # NOTICE : use at most 64 cpus/task. Approximate time for a whole recompilation with 10 cpus : 01:20:00

# Compiler feature extension for aeolus software
# ----------------------------------------------
GMK_AEOLUS_F90 = ifort

# LatLon handling extension for aeolus software
# ---------------------------------------------
GMK_AEOLUS_LATLON_HANDLING = simple

