#!/bin/bash

FILE=NEW_PRUNED.tlt

if [ -n "$1" ]; then
	FILE=$1
fi

sudo rm /workspace/tao-experiments/data/etlts/NEW_EXPORTED.etlt

detectnet_v2 export \
	-m /workspace/tao-experiments/data/pruned/$FILE \
	-o /workspace/tao-experiments/data/etlts/NEW_EXPORTED.etlt \
	-k tlt_encode


