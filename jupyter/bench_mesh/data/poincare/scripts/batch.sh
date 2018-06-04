#!/bin/bash
#@ class            = clallmds+
#@ job_name         = bench_mesh
#@ node_usage       = not_shared
#@ node             = <NB_NODES> 
#@ tasks_per_node   = 2
#@ output           = $(job_name).$(jobid).log
#@ error            = $(job_name).$(jobid).err
#@ wall_clock_limit = 1:00:00
#@ job_type         = mpich
#@ environment      = COPY_ALL 
#@ queue

set -x

n_nodes=<NB_NODES>

unset OMPI_MCA_rmaps_base_schedule_policy
unset OMPI_MCA_orte_process_binding

mpirun -np ${n_nodes} --map-by node bash test_node.sh 
 
for size in 1e5 1e6
do
    for n_sockets in 2
    do
        let "nproc = n_nodes * n_sockets"
        mpirun -np ${nproc} --output-filename stdout_${nproc}_${size} --map-by socket:SPAN --report-bindings test/container/bench_mesh ${size}
    done
done 
