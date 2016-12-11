#!/usr/bin/env bash
# This script is meant to be run by the coordinating machine,
# to start the benchmarks in all the benchmark nodes, and collect their results.
# each node sends its results through scp, and they're put in a directory of the form basho_bench/tests/fmk-bench-date-time
# the basho bench script for individual nodes can be found in this directory/worker-runFMKbench.sh

# It assumes (IMPORTANT!!!)
# 1) Machines have a key in ~/.ssh/known hosts, so ssh does not prompt for passwords
# 2) there exists a file, basho_bench-nodes-list.txt, in this directory with the list of IP addresses of the nodes that will run basho_bench
BenchNodes=`cat script/FMKe/basho_bench-nodes-list.txt`

# Use the following line if one can obtain the public IP address of this machine from its adapter.
    MY_IP=$(ifconfig en0 | grep inet | grep -v inet6 | awk '{print $2}')
    # Otherwise, get the public IP
    #MY_IP=$(dig +short myip.opendns.com @resolver1.opendns.com.)
    # The IP address of the master node is sent to the worker nodes.
    # They use it to scp their results once they're done with their bench


if [ -z "$RUNFMKSETUP" ]; then
  echo "--##--Master ${MY_IP}: missing parameter: RUNFMKSETUP"
  echo "--##--Master ${MY_IP}: Run like: RUNFMKSETUP=<TRUE/FALSE> master-runBenchmarkStarter.sh"
  else
#   NOW CHECK THAT ALL NODES ARE SSH-ABLE!
#   First, check that master node is ssh-able
    RunCommand="ssh -q -o ConnectTimeout=2 -o StrictHostKeyChecking=no ${USER}@${MY_IP} exit"
    echo "--##--Master ${MY_IP}: checking master ssh connectivity with command:"
    echo "--##--Master ${MY_IP}: ${RunCommand}"
    eval $RunCommand
    if [ "$?" = 0  ]; then
        echo "--##--Master ${MY_IP}: SSH working fine on master!: ${MY_IP}"
    else
        echo "--##--Master ${MY_IP}: Unable to SSH master node ${MY_IP}, check what you're doing! good bye!"
        exit 1
    fi

    for Item in ${BenchNodes}
    do
        RunCommand="ssh -q -o ConnectTimeout=2 -o StrictHostKeyChecking=no ${USER}@${Item} exit"
        echo "--##--Master ${MY_IP}: sending ssh command to ${Item} to verify connectivity as:"
        echo "--##--Master ${MY_IP}: ${RunCommand}"
        eval $RunCommand
        if [ "$?" = 0  ]; then
            echo "--##--Master ${MY_IP}: SSH working fine on : ${Item}"
        else
            echo "--##--Master ${MY_IP}: Unable to SSH node ${Item}, check what you're doing! good bye!"
            exit 1
        fi
    done

    # create a directory to store the test results...
    DateTime=`date +%Y-%m-%d-%H-%M-%S`
    BenchResultsDirectory=~/basho_bench/tests/fmk-bench-${DateTime}
    mkdir -p $BenchResultsDirectory
    echo "--##--Master ${MY_IP}: Created dir to receive results: ${BenchResultsDirectory}"
    # Send the command to start benchmarking to each node:
    for Item in ${BenchNodes}
    do
        RunCommand="ssh -o StrictHostKeyChecking=no ${USER}@${Item} BenchResultsDirectory=${BenchResultsDirectory} MasterNodeIp=${MY_IP} RUNFMKSETUP=${RUNFMKSETUP} ~/basho_bench/script/FMKe/worker-runFMKbench.sh"
        echo "--##--Master ${MY_IP}: sending ssh command to ${Item} to run benchmark as:"
        echo "--##--Master ${MY_IP}: ${RunCommand}"
        eval $RunCommand &
    done
fi