#!/bin/bash

echo -n "How many minutes would you like the timer to run? "
read limit
echo
echo "Timing $limit minutes..."
echo
counter=0
while [ $counter != $limit ]; do
	echo "$counter minutes so far...";
	sleep 60
	let "counter = $counter + 1"
done
if [ $counter = $limit ]; then
	echo
	echo "Time's up - $counter minutes have elapsed!"
	echo -e '\a' >&2
	canberra-gtk-play -i complete_download
	exit 0
fi
