#!/bin/bash
# Check input
if [ -z $1 && -z $2]; then
 echo "Usage: cleanup.sh dir ver"
 exit 1
else
    NDIR=$1
    VER=$2
fi

