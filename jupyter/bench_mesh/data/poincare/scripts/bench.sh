set -x

llsubmit batch_1.sh

for n in 1 2 4 8 16 32
do
    sed "s/<NB_NODES>/"$n"/" batch.sh | llsubmit -
done
