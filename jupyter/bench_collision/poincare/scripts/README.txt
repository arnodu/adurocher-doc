Those are the scripts used to generate the output files in the poincare/data.tar.gz archive.

On poincare, place the scripts in the build directory and run them from there.
Collision debug output must be enabled in code
Timers must be activated in cmake to generate the right output
	cd build
	cmake -DBENCH_OptiDis_USE_TIMER=ON ..
	make bench_collision
	bash bench.sh

Warning : This will create multiple jobs. Biggest jobs uses 32 compute nodes
