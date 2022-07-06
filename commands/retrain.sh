#!/bin/bash

FILE=NEW_RETRAINED.tlt
if [ -n "$1" ]; then
	FILE=$1
fi

rm -rf /workspace/tap-experiments/data/retrained/*

detectnet_v2 train \
	-e /workspace/tao-experiments/specs/detectnet_retrain.txt \
	-r /workspace/tao-experiments/data/retrained \
	-k tlt_encode \
	-n resnet18_detector \
	--gpus 1

cp /workspace/tao-experiments/data/retrained/weighs/resnet18_detector.tlt \
	/workspace/tao-experiments/data/tlts/$FILE

