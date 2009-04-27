#!/bin/bash
# usage:
# ./mk_group.sh dvd-i586.list REST-DVD osc/openSUSE:Factory/group.REST-DVD.xml [conditional]

list=$1
name=$2
dest=$3
cond=$4

pushd $PWD/`dirname $dest` > /dev/null
  osc up
popd > /dev/null


echo '<?xml version="1.0" encoding="UTF-8"?>' > $dest
echo "<!-- Autogenerated by desdemona[tm] -->" >> $dest
echo "<group name=\"$name\">" >> $dest
if test -n "$cond"; then
  echo "<conditional name=\"$cond\" />" >> $dest
fi
echo "<packagelist>" >> $dest

for i in `cat $list`;
do
  echo "<package name=\"$i\"/>" >> $dest
done

echo "</packagelist>" >> $dest
echo "</group>" >> $dest

xmllint --format $dest > t && mv t $dest

