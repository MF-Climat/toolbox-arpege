
# Meteo-France RAPS 2024

## tools

This directory contains various applications to control the scientific consistency of the model and to run a gpu configuration.

diffNODE.001_01 : compares two output listings NODE_001 files. The file given as the second argument is the reference of the comparison.

drhook_merge_walltime_max : merges all the DrHook profiles in one unique file. DrHook provides one file per MPI task.

openacc-bind.pl : a script that generate a file name "openacc_bind.txt" to help bind the GPUs.

parallelmethod.pl : a script that generates a file name "lparallelmethod.txt.OPENACCSINGLECOLUMN" needed for execution on GPUs. 
This file tells for each parallel subroutine which method is applied to loops : openmp or openacc.

xpnam : namelist transformation tool for tuning.

Tools : directory which contains a package used in diffNODE.001_01
