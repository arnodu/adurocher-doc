#!/bin/bash
#@ class            = clallmds+
#@ job_name         = bench_p<NB_PROC>_s<PB_SIZE>
#@ node_usage       = not_shared
#@ node             = <NB_NODES> 
#@ tasks_per_node   = 2
#@ output           = $(job_name).$(jobid).log
#@ error            = $(job_name).$(jobid).err
#@ wall_clock_limit = 0:30:00
#@ job_type         = mpich
#@ environment      = COPY_ALL 
#@ queue

set -x

n_nodes=<NB_NODES>
nproc=<NB_PROC>
size=<PB_SIZE>

# Run optidis
#-----------------
mpirun -np ${nproc} --output-filename stdout_collision_p${nproc}_s${size} --map-by socket:SPAN --report-bindings test/collision/bench_collision xml/${size}/data_files.xml
