#!/bin/bash
# Get servers list file name
if [ -z $1 ]; then
    LISTFILE="servers"
else
    LISTFILE=$1
fi
# Check if list exist
if [ ! -f $LISTFILE ]; then
    echo "Servers list file $LISTFILE not found"
    exit 1
fi
# Get servers list
SERVERS=$(cat $LISTFILE)
# Sorting
for SERVER in $SERVERS
do
    echo "serv: $SERVER"
done