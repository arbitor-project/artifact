#!/bin/bash -e

bash gnn.sh

bash qpytorch.sh
pushd native_half 
bash ./expr.sh resnet
popd
pushd arbitor
bash ./expr.sh resnet
popd

# docker run --rm -it 

# docker run --rm -it -e "TERM=xterm-256color" --shm-size 8G arbitor_image bash qpytorch.sh

# plot
gnuplot gnn.gp