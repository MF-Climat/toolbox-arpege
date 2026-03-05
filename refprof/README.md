* Reference NODE.001_01 for ARPEGE-Climat

The objective is to easily check for repeatability and reproducibility.

Reference NODE.001_01 has been produced with the following configuration :

+ NODE.001_01.tl49r.128cpus.16proma.168h.ref
  - NCPU = 124 on 1 node
  - NPROMA = 16
  - CSTOP = h168
  - Geometry = tl49l15r
  - Namelists are from : ~/toolbox-arpege/namelist
  - Restarts are from : /scratch/climat/daac-dev/restart
  - Climatolgies are from : /scratch/climat/daac-dev/restart

+ NODE.001_01.tl127r.128cpus.16proma.168h.ref
  - NCPU = 124 on 1 node
  - NPROMA = 16
  - CSTOP = h168
  - Geometry = tl127l91r
  - Namelists are from : ~/toolbox-arpege/namelist
  - Restarts are from : /scratch/climat/daac-dev/restart
  - Climatolgies are from : /scratch/climat/daac-dev/restart
  
Best option is to use toy scripts in the toolbox.
