#!/usr/bin/env bash

echo starting video compilation `date`
PARENT=/var/www/html/wx
DAY=`date "+%Y-%m-%d"`
DIR=$PARENT/$DAY

echo dir is $DIR

PREVIOUS_HOUR=`date "+%H" --date="-1 hour"`

# gifsicle complained about the size of the GIFs and was very slow so elected not to produce an hour version in GIF
# gifsicle --colors 256 --merge $DIR/$PREVIOUS_HOUR*.gif -o $DIR/$PREVIOUS_HOUR.gif
echo Skipping the GIF compilation because so slow

# There doesn't seem to be a way to cat all the files at once
# Each file needs it's own -cat
rm $DIR/$PREVIOUS_HOUR.mp4
for FILE in $DIR/$PREVIOUS_HOUR*_*.mp4
do
	MP4Box -cat $FILE $DIR/$PREVIOUS_HOUR.mp4
done

rm $PARENT/current_hour.mp4 $PARENT/current_hour.gif
ln $DIR/$PREVIOUS_HOUR.mp4 $PARENT/current_hour.mp4
# ln $DIR/$PREVIOUS_HOUR.gif $PARENT/current_hour.gif

echo ending video compilation `date`
