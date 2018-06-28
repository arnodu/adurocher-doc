#!/bin/bash
set -x

mkdir xml

for size in 1 2 4 8 16 32 64
do
    dir=xml/${size}
    #Generate XML
    cp -r xml_template/ ${dir}/
    cd ${dir}
    sed -i 's/<SIZE>/'${size}'/g' data_files.xml
    # box_max = 10000 * cubic_root(size)
    box_max=$(awk -v N=${size} 'BEGIN{print 20000*N^(1/3)}')
    sed -i 's/<BOX_MAX>/'${box_max}'/g' topo.xml

    #Generate and copy VTK
    cd ../..
    driver/optidisEXE -h 6 -f ${dir}/data_files.xml
    cp res/${size}/VTK/Test_dislocations_*i1.*vtp ${dir}    

    #Change graph file in data_files.xml
    sed -i 's/graph.xml/Test_dislocations_i1.pvtp/g' ${dir}/data_files.xml
done
