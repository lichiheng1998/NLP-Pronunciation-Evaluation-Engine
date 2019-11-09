#!/bin/bash
# converts all .wav-files in the immediate folder that
# this script is executed to
# .raw 16khz, 16bit, little endian, mono
# i.e. for using them with pocketsphinx:
# http://cmusphinx.sourceforge.net/
#
# all converted files will be in the new subdirectory
# "converted" inside the directory this script is
# executed; the original files will not be touched
#
# you have to install sox prior to running this
# script and add it to your bash profile or add to the directory
# http://sox.sourceforge.net/
#
# Author: benjgorman
# http://benjgorman.com
EXT=wav
DIRECTORY=converted
if [ ! -d DIRECTORY ]; then
  mkdir $DIRECTORY
fi

for d in $(find audio -maxdepth 1 -type d)
do
  if [ ! -d ./$DIRECTORY/${d#*/} ]; then
    mkdir ./$DIRECTORY/${d#*/}
  fi
  for i in $d/*; do
    if [ "${i}" != "${i%.${EXT}}" ];then
	
        echo "Working on File $i"
        sox -t wav "$i" -r 16000 "./$DIRECTORY/${i#*/}.raw"
        if [ $? -eq 0 ]
        then
        echo "Successfully converted File: $i"
        else
        echo "File \"$i\" could not be converted. Aborting!"
        exit 1
        fi
    fi  
  done
done
exit 0
