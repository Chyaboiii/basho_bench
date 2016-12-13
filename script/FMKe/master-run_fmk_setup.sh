#!/usr/bin/env bash


# This script runs, from the master machine, the fmk setup script.

#INPUT:
# 1) MY_IP: the IP address of this machine
# 2)

########################################################
    # Run (or not) the FMKe setup script
##########################################################
# Make the setup test executable
chmod +x ~/FMKe/test/fmk_setup_script.erl

# This is only necessary when running on OS X, erlang 19
# might be removed, but won't harm otherwise...
PATH="$PATH:/opt/local/lib/erlang/erts-8.1/bin/"

# first check that fmk is active (pingable) on that node:
FmkPing=pong #$(~/basho_bench/script/FMKe/ping.erl 'fmk@${MY_IP}')
echo "##Node:${MY_IP}:Pinging 'fmk@${MY_IP}', got: ${FmkPing}"
if [ "$FmkPing" = pong ] ; then
    # Run the setup test
    if [ "$RUNFMKSETUP" = TRUE ] ; then
        echo "##Node:${MY_IP}: cding into ~/FMKe"
        cd ~/FMKe/
        pwd
        SetupCommand="~/FMKe/test/fmk_setup_script.erl 1 fmk@${MY_IP}"
        echo "##Node:${MY_IP}: Running Setup script with command: "
        echo "##Node:${MY_IP}: ${SetupCommand}"
        eval ${SetupCommand}
    else
        echo "##Node:${MY_IP}: not running fmk setup."

    fi
fi