#!/bin/bash
# This script is going to be executed inside an amazon virtual machine and will
# clone and build a list of required git repositories.

set -e # Any subsequent(*) commands which fail will cause the shell script
       # to exit immediately

# add ESL as a repository
sudo wget -c -O- http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
sudo echo "deb http://packages.erlang-solutions.com/ubuntu xenial contrib" | sudo tee -a /etc/apt/sources.list.d/erlang_solutions.list > /dev/null

sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes install build-essential autoconf git r-base erlang

# needed to later build the PNG image
sudo chown ubuntu /usr/local/lib/R/site-library/

 # env
 BIN_DIR=`pwd`
 cd $BIN_DIR

 #############################  antidote @############################
 ANTIDOTE_DIR=$HOME

 cd $ANTIDOTE_DIR
 git clone https://github.com/SyncFree/antidote

 cd antidote
 git checkout build-local-cluster
 make rel

 cd $BIN_DIR

 ############################## FMKe #################################
 FMKE_DIR=$HOME

 cd $FMKE_DIR
 git clone https://github.com/goncalotomas/FMKe
 cd FMKe
 git checkout perf-and-errors
 make rel

 cd $BIN_DIR

 ########################## basho_bensh ##############################
 BASHO_BENSH_DIR=$HOME

 cd $BASHO_BENSH_DIR
 git clone https://github.com/SyncFree/basho_bench
 cd basho_bench
 git checkout antidote_pb_fmk_aws
 make all