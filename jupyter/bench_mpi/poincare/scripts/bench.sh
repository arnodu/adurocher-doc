set -x

strong_size=16

submit_batch(){
    n_nodes=$1
    n_proc=$2
    size=$3
    tree_h=$4
    sed "s/<NB_NODES>/"${n_nodes}"/" batch.sh | sed "s/<NB_PROC>/"${n_proc}"/" | sed "s/<PB_SIZE>/"${size}"/" | sed "s/<TREE_H>/"${tree_h}"/" | llsubmit -
} 

for tree_h in 8 9 10
do
    submit_batch 1 1 1 $tree_h
    submit_batch 1 1 $strong_size $tree_h
    for n in 1 2 4 8 16 32
    do
        let 'nproc = 2*n'
        submit_batch $n $nproc $nproc $tree_h
        submit_batch $n $nproc $strong_size $tree_h 
    done
done
