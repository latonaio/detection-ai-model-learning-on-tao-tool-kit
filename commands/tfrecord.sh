#!/bin/bash

mkdir -p /workspace/tao-experiments/specs/tfrecords/
rm /workspace/tao-experiments/specs/tfrecords/*

detectnet_v2 dataset_convert \
	-d /workspace/tao-experiments/specs/detectnet_tfrecords.txt \
	-o /workspace/tao-experiments/specs/tfrecords/kitti_trainval


