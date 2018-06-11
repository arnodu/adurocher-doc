#!/bin/bash
#@ class            = clallmds+
#@ job_name         = bench_mesh
#@ node_usage       = not_shared
#@ node             = 1 
#@ tasks_per_node   = 1
#@ output           = $(job_name).$(jobid).log
#@ error            = $(job_name).$(jobid).err
#@ wall_clock_limit = 4:00:00
#@ job_type         = mpich
#@ environment      = COPY_ALL 
#@ queue

set -x

nproc=1

unset OMPI_MCA_rmaps_base_schedule_policy
unset OMPI_MCA_orte_process_binding
 
for size in 1e5 1e6
do
    numactl --physcpubind=1 test/container/bench_mesh ${size} > stdout_core_${size}
    numactl --cpunodebind=1 test/container/bench_mesh ${size} > stdout_numa_${size}
    test/container/bench_mesh ${size} > stdout_node_${size}
done 
