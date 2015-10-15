#!/bin/bash

#Look for mytar
teststr=$( ls mytar )
if test -z $teststr ; then
	echo "Mytar not found, nothing to test!"
	exit
else 
	echo "Mytar program found. Testing..."
fi

#Delete tmp if it exists
if test -d tmp ; then
	echo "tmp folder found. Removing..."
	echo "rm -r tmp"
	rm -r tmp
else 
	echo "tmp folder not found."
fi

#Create and switch to tmp
mkdir tmp
cd tmp

#Create files inside tmp
echo "Creating the temporary files for testing..."
echo "Hello world!" > file1.txt
head -n 10 /etc/passwd > file2.txt
head -c 1024 /dev/urandom > file3.dat

#Create the tar
files=$( ls )
../mytar -c -f filetar.mtar $files

teststr=$( ls filetar.mtar )
if test -z $teststr ; then 
	echo "There was an error when creating the file. So sorry."
	exit
else
	echo "Tar file created succesfully."
fi

#Create out directory and copy filetar to it
mkdir out
cat filetar.mtar > out/filetar.mtar

#Switch to /out and extract tar
cd out
../../mytar -x -f filetar.mtar

echo "Performing test..."
echo " "

for i in $( ls )
do
	result=$( diff $i ../$i )
	if [ "$result" != "" ] ; then
		echo "The file $i does not coincide. Ending program..."
		exit
	fi
done	

cd ../..
echo "Success"

exit
