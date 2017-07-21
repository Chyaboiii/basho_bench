#!/bin/bash

set -e

if [[ $# -lt 3 ]]; then
    echo "Error: usage $0 <private_key_file> <bench node1> <bench node2>"
    exit 2
fi;

PRIVATEKEY=$1
KEY_FILE_NAME=$(basename $PRIVATEKEY)

SSH_USERNAME=ubuntu
SSH_OPTIONS="-i $PRIVATEKEY -o StrictHostKeyChecking=no"

scp $SSH_OPTIONS ./dataset/1 $SSH_USERNAME@$2:~/1
scp $SSH_OPTIONS ./dataset/2 $SSH_USERNAME@$2:~/2
scp $SSH_OPTIONS ./dataset/3 $SSH_USERNAME@$2:~/3
scp $SSH_OPTIONS ./dataset/4 $SSH_USERNAME@$2:~/4
scp $SSH_OPTIONS ./dataset/5 $SSH_USERNAME@$2:~/5
scp $SSH_OPTIONS ./dataset/6 $SSH_USERNAME@$2:~/6
scp $SSH_OPTIONS ./dataset/7 $SSH_USERNAME@$2:~/7
scp $SSH_OPTIONS ./dataset/8 $SSH_USERNAME@$2:~/8

scp $SSH_OPTIONS ./dataset/9 $SSH_USERNAME@$3:~/1
scp $SSH_OPTIONS ./dataset/10 $SSH_USERNAME@$3:~/2
scp $SSH_OPTIONS ./dataset/11 $SSH_USERNAME@$3:~/3
scp $SSH_OPTIONS ./dataset/12 $SSH_USERNAME@$3:~/4
scp $SSH_OPTIONS ./dataset/13 $SSH_USERNAME@$3:~/5
scp $SSH_OPTIONS ./dataset/14 $SSH_USERNAME@$3:~/6
scp $SSH_OPTIONS ./dataset/15 $SSH_USERNAME@$3:~/7
scp $SSH_OPTIONS ./dataset/16 $SSH_USERNAME@$3:~/8
