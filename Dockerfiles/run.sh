#!/bin/sh
set -e

/opt/basho_bench -N $BENCH_NODE -C $COOKIE /opt/bigdata.config & wait ${!}
