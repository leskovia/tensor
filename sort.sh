#!/bin/bash
# Get servers list file name
if [ -z $1 ]; then
    LISTFILE=$1
else
    LISTFILE="servers"
fi

