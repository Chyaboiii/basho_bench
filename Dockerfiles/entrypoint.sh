#!/bin/bash
set -e

sed -ie "s#{antidote_nodes, .*}.#{antidote_nodes, ['${ANTIDOTE_NODE}']}.#g" $CONFIG
sed -ie "s#{bench_node, .*}.#{bench_node, ['${BENCH_NODE}', longnames]}.#g" $CONFIG
sed -ie "s#{bigdata, .*}.#{bigdata, '/bigdata'}.#g" $CONFIG
sed -ie "s#{operations, .*}.#{operations, [{add, ${ADD_N}}, {add_set, ${ADD_SET_N}}]}.#g" $CONFIG

touch setup_ok

exec "$@"
