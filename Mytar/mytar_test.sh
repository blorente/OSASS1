#!/bin/bash

#Build the project OK
make
echo "Project built successfully."


#Get files to test OK
cd test
files=$( ls )
cd ..
echo "Files to be tarred: " $files

#Execute mytar
mkdir tmp
./mytar -c -f /tmp/out.tar $files

#Change directories to temp
cd tmp

#Untar the files here
#../mytar -x -f out.tar

#Compare the files with the originals
#for file in $( ls ) do

#	if [ diff $file ../$file ] ; then
#		echo "File " $file " untarred successfully."
#	else
#		echo "There was an error when untarring " $file "."
#	fi
#done
#Delete temporal files and clean the project
#cd ..
#rm -rf /tmp

make clean

return 0
