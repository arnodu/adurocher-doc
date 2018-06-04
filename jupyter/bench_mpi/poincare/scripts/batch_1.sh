#!/bin/bash
#@ class            = clallmds+
#@ job_name         = bench_mpi_1
#@ node_usage       = not_shared
#@ node             = 1 
#@ tasks_per_node   = 2
#@ output           = $(job_name).$(jobid).log
#@ error            = $(job_name).$(jobid).err
#@ wall_clock_limit = 1:00:00
#@ job_type         = mpich
#@ environment      = COPY_ALL 
#@ queue

set -x

nproc=1


# Generate xml files
#-----------------
cp -r xml_template/ xml_tmp/
cd xml_tmp
sed 's/<NB_PROC>/'${nproc}'/g' data_files.xml > data_files_${nproc}.xml
# box_max = 10000 * cubic_root(nproc)
box_max=$(awk -v N=$nproc 'BEGIN{print 20000*N^(1/3)}')
sed 's/<BOX_MAX>/'${box_max}'/g' topo.xml > topo_${nproc}.xml
cd ..

# Run optidis
#-----------------
mpirun -np ${nproc} --output-filename stdout_optidis_${nproc} --map-by socket:SPAN --report-bindings driver/optidisEXE -h 8 -f xml_tmp/data_files_${nproc}.xml

