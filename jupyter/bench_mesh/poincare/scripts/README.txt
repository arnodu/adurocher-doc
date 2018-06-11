Those are the scripts user to generate the output files in the poincare/data folder.

On poincare, place the scripts in the build directory and run them from there:
	cd build
	cmake ..
	make bench_mesh
	bash bench.sh

This will create multiple jobs. The biggest job uses 32 compute nodes
