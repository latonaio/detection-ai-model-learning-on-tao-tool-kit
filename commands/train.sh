#!/bin/bash

FILE=NEW_TRAINED.tlt

if [ -n "$1" ]; then
	FILE=$1
fi

echo "created file will be copied to tlts dir with named $1"
sleep 3

rm -rf /workspace/tao-experiments/data/trained/*

detectnet_v2 train \
	-e /workspace/tao-experiments/specs/detectnet_train.txt  \
	-r /workspace/tao-experiments/data/trained \
	-k tlt_encode \
	-n resnet18_detector \
	--gpus 1

# copy the file only which created at last to tlts dir.
# 最終成果物だけ tlts dir にコピーする
cp /workspace/tao-experiments/data/trained/weights/resnet18_detector.tlt \
	/workspace/tao-expriments/data/tlts/$FILE

