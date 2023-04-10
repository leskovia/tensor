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
# Empty groups
NOT_RESOLVING=""
NOT_RESPONDING=""
RESPONDING=""
# Sorting
for SERVER in $SERVERS
do
    RES=$(ping -c 1 $SERVER 2>&1)
    if echo $RES | grep "not known" >>/dev/null;
    then
        NOT_RESOLVING+=($SERVER)
    fi
    if echo $RES | grep "0 received" >>/dev/null;
    then
        IP=$(echo $RES | grep "bytes of data" | awk '{print $3}' | egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}')
        NOT_RESPONDING+=($SERVER,$IP)
    fi
    if echo $RES | grep "1 received" >>/dev/null;
    then
        IP=$(echo $RES | grep "bytes of data" | awk '{print $3}' | egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}')
        RESPONDING+=($SERVER,$IP)
    fi
done
# 1 group
echo "## 1, NOT RESOLVED ##"
for N in ${NOT_RESOLVING[@]}
do
    echo $N
done
# 2 group
echo "## 2, RESOLVED, NOT RESPONDING ##"
for N in ${NOT_RESPONDING[@]}
do
    echo $N
done
# 3 group
echo "## 3, RESOLVED, RESPONDING ##"
for N in ${RESPONDING[@]}
do
    echo $N
done
