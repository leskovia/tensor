#!/bin/bash
NAME_STARTS="saby-"
OLD_DIRECTORY="/opt/misc/"
NEW_DIRECTORY="/srv/data"
# Get Units list
UNITLIST=$(systemctl status $NAME_STARTS* | grep vendor | awk '{print $3}' | sed 's/^.//;s/.$//')
for UNIT in $UNITLIST
do
echo $UNIT
done