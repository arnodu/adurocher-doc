#!/bin/bash
#@ class            = clallmds+
#@ job_name         = bench_p<NB_PROC>_s<PB_SIZE>_h<TREE_H>
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
tree_h=<TREE_H>

# Generate xml files
#-----------------
cp -r xml_template/ xml_tmp/
cd xml_tmp
sed 's/<SIZE>/'${size}'/g' data_files.xml > data_files_${size}.xml
# box_max = 10000 * cubic_root(size)
box_max=$(awk -v N=${size} 'BEGIN{print 20000*N^(1/3)}')
sed 's/<BOX_MAX>/'${box_max}'/g' topo.xml > topo_${size}.xml
cd ..

# Run optidis
#-----------------
mpirun -np ${nproc} --output-filename stdout_optidis_p${nproc}_s${size}_h${tree_h} --map-by socket:SPAN --report-bindings driver/optidisEXE -h ${tree_h} -f xml_tmp/data_files_${size}.xml

mpirun -np ${nproc} --map-by socket:SPAN rm -rf /tmpdir/optidis_res
