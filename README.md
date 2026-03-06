# Toolbox-ARPEGE 🌍


## Getting started 🚀

This is a Toolbox for **ARPEGE-CLIMAT**. The aim is to provide tools usefull to prepare and debug a configuration of ARPEGE-CLIMAT.

💬 This toolbox is open to improvement and enrichment via pull requests.


## Current state ⚙️

Repository and scripts initiated with CY49T1_clim1.03.

Geometries tested and available on belenos :
+ ✅ TL49
+ ✅ TL127
+ 🏗️ TC127 (only pgd, prep, c92x)
+ 🏗️ TCO127 (only pgd, prep, c92x)

## Toy(s) 🎮

It provides very simple script to run the model. Data necessary to run the model should be available in a rundir from ECLIS. It is very easy to run without XIOS, just use the switch.
Data are also available in a DAAC-DEV directory on belenos + a directory on Lustre.

⚠️ Note that for some reasons, XIOS does not work with the TL49. Shut if down for the moment.


## PGD-PREP 🏔️

It provide a script to generate a PGD and a PREP for a given gemoetry. One restart to start from is available and other necessary data are available in a DAAC-DEV directory on belenos + a directory on Lustre.

⚠️ TRIP and LULC is not supported yet.


## Namelists 📑

Namelists are prepared to be used in toys scripts i.e. : some keys are set to AUTO or with variables modified by the scripts in toy directory.

Namelists for c92x are also provided with variables automatically modified by the script.


## c92x 🪂

c923 : scripts to generate ARPEGE Climatology on a given geometry. Necessary data are available in a DAAC-DEV directory on belenos + a directory on Lustre.

c927 : scripts to interpolate ARPEGE restart on a given geometry. One restart and the associated climatology file are available in a DAAC-DEV directory on belenos + a directory on Lustre. The climatology file on the given geometry is required and can be build with the c923 script.


## Refprof 🪩

Reference DrHook profiling and NODE.001_01. These are made available so that you can check the reproducibility of your application.

The restart files and scripts used to generate the NODE are listed in the README.md file in the directory.

## rgrid 🌐

Script to run rgrid and extract relevant information. To be completed.

## Tool 🔨

A few tools usefull for DrHook output summary and NODE comparison.


## Authors and acknowledgment 🙏

Repository initiated and fed by G. Dayon.
Thanks to R. El Khatib, D. St-Martin and R. Roehrig (among others) for the scripts baseline (from RAPS2024, ARP-GEM toy and mitraillette)
