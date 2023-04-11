#!/bin/bash
# Check input
if [[ -z $1 || -z $2 ]]; then
    echo "Usage: cleanup.sh dir ver"
    exit 1
else
    NDIR=$1
    VER=$2
fi
if [ ${NDIR: -1} != "/" ]
then
    NDIR="${NDIR}/"
fi
# Check workdir
if [ ! -e $NDIR ]; then
    echo "directory not found"
    exit 1
fi
DISTROS=$(find $NDIR* -maxdepth 1 -type d)
for DISTR in $DISTROS
do
    DISTR_VER=$(echo $DISTR | awk -F_ '{print $NF}')
    if [ $DISTR_VER = "`echo -e "$DISTR_VER\n$VER" | sort -V -r | head -n1`" ];
    then
        echo "new $DISTR"
    else
        #Old
        echo "delete old $DISTR"
        rm -r $DISTR
    fi
done
