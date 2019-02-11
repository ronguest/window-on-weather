#!/usr/bin/env bash

# This script runs every day
# It removes the directory and files from 2 days previous so we don't fill up the SD card

DELETE_DATE=`date "+%Y-%m-%d" --date="-2 day"`
DELETE_DIR=/var/www/html/wx/$DELETE_DATE
echo deleting $DELETE_DIR

rm $DELETE_DIR/*.gif $DELETE_DIR/*.mp4
rmdir $DELETE_DIR
