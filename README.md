# Artifact

## Abstract
We provide the source code and scripts for Arbitor to functionally reproduce the results of our experiments and case studies presented in the paper. The provided instructions enable users to train models with a user-provided data format and to train with the emulation of approximate computing or sparse-aware computing enabled.
By following our instructions, users can expect to obtain results that are similar to those presented in the paper.
## Requirements
### Hardware requirement:
Arbitor NVIDIA GPU to run. An Nvidia GPU with the Turing architecture or a more recent architecture and a general-purpose multi-core CPU, preferably 16 or 32 cores, should be sufficient for running the artifact. We recommend using a machine equipped with four NVIDIA 2080Ti to run large-scale experiments in a fast manner

### Software requirement:
The experiments provided in this artifact is prepared to run inside a docker container. We recommend using a machine with Ubuntu 20.04 with docker and NVIDIA driver installed to reproduce the results.


## Installation
We provide docker files to set up the runtime environment for all the experiments. 

* Install docker following the instructions in [https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/).
* Make sure the machine has NVIDIA GPU(s) and corresponding driver installed. If the NVIDIA driver is not installed, follow the instructions [here](https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html) to install it. 
* Clone the git repository using the following command: 
```
git clone --recursive https://github.com/arbitor-project/artifact 
```

## Experiment Workflow
After cloning the artifact, execute the following commands:
```
cd artifact
bash run.sh
```
to enter the docker environment.

### Reproducing QPytorch ResNet-18 result with emulated FP16
When inside the docker environment, execute 
```
cd /root/
bash qpytorch.sh
```
to train ResNet18 with QPyTorch-emulated FP16. It should be expected the final validation accuracy is very close to or even higher than the FP32 baseline accuracy (93.78%).

### Reproducing TensorFlow ResNet-18 result with native FP16
As TensorFlow uses FP32 to replace FP16 in many computations and especially accumulation in dot product-based operations, we need to use a modified version to run everything in FP16. 

When inside the docker environment, execute
``` 
cd /root/native_half/
bash ./expr.sh resnet
```
to build the TensorFlow and train ResNet-18 using native FP16. The final validation accuracy should be slightly smaller than the FP32 baseline accuracy (~1%).

### Reproducing Arbitor ResNet-18 result with emulated FP16
When inside the docker environment, if `data_format.sh` is not modified, directly execute
```
cd /root/arbitor/
bash ./expr.sh resnet
```
to build the TensorFlow and train ResNet-18 using Arbitor-emulated FP16. The expected final accuracy should be similar to the native FP16 result above.
Note that if `data_format.sh` is modified, need to set it to fit FP16 emulation before running `expr.sh`:
```
F_OR_P=emu_float
ACC=cus_acc

EXP=5
MANTISSA=10
SUBNORMAL=_subnormal
```

### Experiment Customization
To reproduce results in case studies (section 5 in the paper), change the `data_format.sh` file located at `/root/arbitor/`. 
Specifically, `F_OR_P` decides whether to emulate float or posit numbers. 
`ACC` represents the data type for accumulation, where `f32_acc` is to use FP32 to accumulate during a dot product, and `cus_acc` is to use the same type as computation for accumulation. In floating point configs, `EXP` and `MANTISSA` represent the bit-width of exponent and mantissa respectively. Setting `SUBNORMAL=_subnormal` causes subnormal numbers to be enabled during emulation and `SUBNORMAL=_wo_subnormal` otherwise.
For Posit configs, `POSIT_NBITS` is the whole width of the number format, and `POSIT_ES` is the width of the exponent of Posit.
After changing `data_format.sh`, run 
```
cd /root/arbitor/
bash ./expr.sh [gnn | transformer | crnn | resnet]
```
We recommend running `gnn` or `crnn` first as they are relatively fast. `resnet` with accumulation sometimes will take days to finish.