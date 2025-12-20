
## OpenMPI 5

```bash
wget https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.9.tar.gz
```

```bash
tar -xf openmpi-5.0.9.tar.gz
cd openmpi-5.0.9
```

```bash
./configure --prefix=<install_path>
```

```bash
make -j$(nproc)
make install
```

---

## DMR

Clone the DMR repository:

```bash
git clone https://gitlab.bsc.es/siserte/dmr.git
```

---

Ensure that your compiler can also find the include header files of Slurm on its search paths or set the SLURM_INCLUDE environment variable to point to them. If they are not exposed on your system, you may be able to get around the problem by getting them from the appropriate version of Slurm's GitHub page.

If necessary, clone Slurm to obtain the headers:

```bash
git clone https://github.com/SchedMD/slurm.git
cd slurm
```

```bash
git checkout slurm-23.11
```

```bash
./configure
```
---

Add the following lines to your ~/.bashrc:

```bash
export SLURM_LIB=/usr/lib/x86_64-linux-gnu/slurm-wlm
export LD_LIBRARY_PATH=$SLURM_LIB:$LD_LIBRARY_PATH
export SLURM_INCLUDE=<path_to_cloned_slurm>
```
![slurmexport](images/export_slurm.png)

---


Please note that the current version of dmr@jobs was built primarily to support Slurm 23.02.7 and that versions other than this may not work or require adjustments

Open the file:
```bash
dmr/src/dmr_slurm.c
```

Modify the hostlist line.

Change from:

![imagem1](images/image1.png)

To:

![imagem2](images/image2.png)

---

After this modification, DMR should compile correctly.

Enter the DMR directory and run:

```bash
make
```

---


Add the following to your ~/.bashrc:

```bash
export DMR_PATH=<path_to_dmr_directory>
export LD_LIBRARY_PATH=$DMR_PATH/lib:$LD_LIBRARY_PATH
export PATH=$DMR_PATH/bin:$PATH
```
![dmrexport](images/export_dmr.png)



---

## Hello World Example

Go to the example directory:

```bash
cd dmr/examples/hello-world-dmr
```

Run:

```bash
make
```

Modify the sbatch script to add the -x flag; otherwise, the DMR shared library (.so) will not be found when running from the repository.

In the command below:

```bash
cmd="$DMR_PATH/bin/dmr_wrapper prterun --host $NODELIST_WITH_COUNTS -np 2 --prtemca ras ^slurm --prtemca plm ^slurm ./hello-world"
```

add the -x flag to export LD_LIBRARY_PATH

```bash
cmd="$DMR_PATH/bin/dmr_wrapper prterun --host $NODELIST_WITH_COUNTS -np 2 --prtemca ras ^slurm --prtemca plm ^slurm -x LD_LIBRARY_PATH=<path_to_dmr>/lib:$LD_LIBRARY_PATH ./hello-world"
```


```bash
sbatch batch_submit.sbatch
```


