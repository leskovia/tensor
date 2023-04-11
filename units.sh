#!/bin/bash
NAME_STARTS="saby-"
OLD_DIRECTORY="/opt/misc/"
NEW_DIRECTORY="/srv/data/"
# Get Units list
UNITLIST=$(systemctl show $NAME_STARTS* --type=service | grep FragmentPath | awk -F'=' '{print $2}')
for UNIT in $UNITLIST
do
UNITNAME=$(echo $UNIT | awk -F/ '{print $NF}')
echo $UNITNAME
systemctl stop $UNITNAME
mv  $OLD_DIRECTORY$UNITNAME $NEW_DIRECTORY$UNITNAME
sed -i "s#$OLD_DIRECTORY#$NEW_DIRECTORY#" $UNIT
systemctl start $UNITNAME
done