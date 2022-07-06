#!/bin/bash

# usage
# ./prune.sh train [filename] [pth] [key]
# ./prune.sh retrain [filename] [pth] [key]

if [ $# -lt 1 ]; then
	echo "BAD REQUEST. train? retrain?"
	echo "    usage"
	echo "    $ ./prune.sh [re]train [filename] [pth] [key]"
	echo ""
	exit -1
fi

if [ "$1" = "train" ]; then
	FILE=NEW_TRAINED.tlt
elif [ "$1" = "retrain" ]; then
	FILE=NEW_RETRAINED.tlt
else
	echo "BAD REQUEST. train? retrain?"
	echo "    usage"
	echo "    $ ./prune.sh [re]train [filename] [pth] [key]"
	echo ""
	exit -1
fi

PTH=0.0000052
KEY=tlt_encode

if [ -n "$2" ]; then
	FILE=$2
fi

if [ -n "$3" ]; then
	PTH=$3
fi

if [ -n "$4" ]; then
	KEY=$4
fi

echo 1 = $1
echo 2 = $2
echo 3 = $3, PTH = $PTH
echo 4 = $4, KEY = $KEY

detectnet_v2 prune \
	--gpus 1 \
	-m /workspace/tao-experiments/data/tlts/$FILE \
	-o /workspace/tao-experiments/data/pruned/NEW_PRUNED.tlt \
	-k $KEY \
	-eq union \
	-pth $PTH \

