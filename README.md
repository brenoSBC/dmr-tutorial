
## OpenMPI 5

```bash
wget https://download.open-mpi.org/release/open-mpi/v5.0/openmpi-5.0.9.tar.gz
```

```bash
tar -xf openmpi-5.0.9.tar.gz
cd openmpi-5.0.9
```

```bash
./configure --prefix=<caminho_onde_instalar>
```

```bash
make -j$(nproc)
make install
```

---

## DMR

Clone o repositório do DMR:

```bash
git clone https://gitlab.bsc.es/siserte/dmr.git
```

---

## 3. Dependência do Slurm

Ensure that your compiler can also find the include header files of Slurm on its search paths or set the SLURM_INCLUDE environment variable to point to them. If they are not exposed on your system, you may be able to get around the problem by getting them from the appropriate version of Slurm's GitHub page.

Clone o Slurm:

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

Adicione no ~/.bashrc:

```bash
export SLURM_LIB=/usr/lib/x86_64-linux-gnu/slurm-wlm
export LD_LIBRARY_PATH=$SLURM_LIB:$LD_LIBRARY_PATH
export SLURM_INCLUDE=<caminho_para_o_slurm_clonado>
```

---


Please note that the current version of dmr@jobs was built primarily to support Slurm 23.02.7 and that versions other than this may not work or require adjustments

vá para dmr/src/dmr_slurm.c
é necessário modificar a linha hostlist:

de:

![imagem1](image1.png)

para:
![imagem2](image2.png)

---

## 6. Compilando o DMR

Entre no diretório do DMR e execute:

```bash
make
```

---


Adicione também ao `~/.bashrc`:

```bash
export DMR_PATH=<localização_do_diretório_dmr>
export LD_LIBRARY_PATH=$DMR_PATH/lib:$LD_LIBRARY_PATH
export PATH=$DMR_PATH/bin:$PATH
```

Recarregue novamente o ambiente:

```bash
source ~/.bashrc
```

---


