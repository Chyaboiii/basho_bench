#!/bin/bash

AllNodes=$1
Cookie=$2
File="./"$3
{antidote_pb_ips, [{127,0,0,1}]}.
sudo sed -i '/antidote_pb_ips/d' $File 
BenchConfig="{antidote_pb_ips, ["
for Node in $AllNodes
do
    Node=\'$Node\',
	BenchConfig=$BenchConfig$Node
done
BenchConfig=${BenchConfig::-1}"]}."
echo $BenchConfig
sudo echo "$BenchConfig" >> $File
