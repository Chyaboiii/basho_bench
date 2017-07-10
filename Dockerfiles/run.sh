#!/bin/sh
set -e

epmd && sleep 100 &
/opt/basho_bench -N $BENCH_NODE -C $COOKIE /opt/bigdata.config & wait ${!} &
cp -r /tests/current /data & wait ${!}
