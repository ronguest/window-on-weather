#!/usr/bin/env bash

# This script capture a series of GIFs from the Pi camera and constructs and animated GIF using gifcicle
# It then captures a timelapse type video using a Python script in video.py, in MP4 format

# PARENT is the web server based destination for the video files
# There is a subdirectory for each day and the files are stored in that directory
# A current.gif and current.mp4 are linked to the most recent videos at the PARENT level
# Deletion of old days is handled in a separate script

PARENT=/var/www/html/wx
DAY=`date "+%Y-%m-%d"`
DIR=$PARENT/$DAY
mkdir $DIR
NAME=`date "+%H_%M"`
echo Start collecting images `date`
echo gif directory is $DIR
echo gif file name will be $NAME

TEMP=/var/tmp/wx_gifs
mkdir $TEMP

# Grab one GIF at a time
for (( i = 0; i < 20; i++ )); do
    raspistill -h 972 -w 1296 --encoding gif  -o $TEMP/$i.gif
done

gifsicle --colors 256 --delay=10 --loop $TEMP/* > $DIR/$NAME.gif
rm $PARENT/current.gif $TEMP/*.gif
ln $DIR/$NAME.gif $PARENT/current.gif

echo Get MP4
# For simplicty sake so we don't need to pass PARENT to the Python script
# We make PARENT the current directory first
cd $PARENT
rm $PARENT/test.h264

python /home/pi/wx_video/video.py
# MP4Box is used to add the MP4 wrapper so the result is playable
MP4Box -add $PARENT/test.h264 $DIR/$NAME.mp4

rm $PARENT/current.mp4
ln $DIR/$NAME.mp4 $PARENT/current.mp4

echo Done collecting images `date`
