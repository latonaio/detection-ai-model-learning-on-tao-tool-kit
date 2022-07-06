#!/bin/bash

HERE=$(cd "$(dirname "$0")"; pwd)

docker run --runtime=nvidia -it --rm \
	-v $HERE/data:/workspace/tao-experiments/data \
	-v $HERE/specs:/workspace/tao-experiments/specs \
	-v $HERE/ngccli/ngc-cli:/opt/ngccli/ngc \
	-v $HERE/commands:/workspace/tao-experiments/commands \
	nvcr.io/nvidia/tao/tao-toolkit-tf:v3.21.11-tf1.15.4-py3 /bin/bash

