CC 			= mpicc
DMRFLAGS 	= -I${DMR_PATH}/include -L${DMR_PATH}/lib -ldmratjobs
SLURMFLAGS  = -L/usr/lib/x86_64-linux-gnu/slurm-wlm -lslurmfull -Wl,-rpath=/usr/lib/x86_64-linux_gnu/slurm-wlm
FLAGS  		= -O3 -Wall -g

all: hello-world

hello-world: hello-world.c
	$(CC) $(FLAGS) $(DMRFLAGS) hello-world.c -o hello-world $(DMRFLAGS) $(SLURMFLAGS)

clean:
	rm -f hello-world *.o slurm-*.out


