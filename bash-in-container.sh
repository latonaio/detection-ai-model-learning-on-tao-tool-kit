#!/bin/bash
# 使用方法
# ./bash-in-container.sh [実行したいコマンド]
#
# 用途
# jupyter note 内から tao コマンドを実行するとコンテナが作成される
# 実行時の container 内部の状態を知りたい場合に、使用できる。
# 
# jupyter note 内から tao コマンドを実行した 1秒後〜実行失敗時刻までの間に、
# このスクリプトを実行する必要がある。
# 

CMD=$1

docker ps | \
	grep nvcr.io/nvidia/tao/tao-toolkit-tf:v3.22.05-tf1.15.4-py3 | \
	awk '{print  $10}' | \
	xargs -I{} docker exec {} $CMD

