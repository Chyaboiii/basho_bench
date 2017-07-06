#!/bin/bash
set -e

sed -ie "s#{antidote_nodes, .*}.#{antidote_nodes, ['${ANTIDOTE_NODE}']}.#g" $CONFIG
sed -ie "s#{bench_node, .*}.#{bench_node, ['${BENCH_NODE}', longnames]}.#g" $CONFIG

touch setup_ok

exec "$@"
