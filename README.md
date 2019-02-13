# Time-lapse Video Project

This project was created in order to collect time-lapse videos of the sky outside my house on a continuous basis (24/7). It could be used to collect time-lapse video of anything but this is the purpose for which it was built.

## Required Hardware
* Raspberry Pi with WiFi or Ethernet (I used a Pi B2 with a TP-Link WiFi adapter)
* Raspberry Pi camera (I used a V1 camera but V2 should work as well)
* Micro SD card (I started with an 8GB card but it wasn't large enough. 16GB would have worked but I had a 32GB handy and used that)

You should have a web server configured as well as having enabled the camera. I find it easiest to work with the Pi over SSH rather than using a display+keyboard+mouse. If you feel the same you will also need to enable SSH access. The Pi webserver is assumed to store it's files in /var/www/html. The "wx" directory needs to be created manually within that directory.

For camera installation instruction [refer to this web site](https://www.raspberrypi.org/documentation/usage/camera/README.md).

## Software Components
* crontab entries to launch the necessary scripts on a schedule
* Three shell scripts
  * _capture_wx.sh_ - captures a series of GIF images then combines them into an animated GIF and calls video.py to create a separate MP4 time-lapse
  * _compile_wx.sh_ - runs once an hour and combines the previous hour's MP4 time-lapse into a single file
  * _delete_wx.sh_ - runs once a day and deletes the video files created 2 days prior
* One Python script
  * _video.py_ - records time-lapse in MP4, called from capture_wx.sh
    * Note: If raspivid is used directly the first frames are highly over-exposed while auto-exposure makes adjustments. video.py records and throws away a few seconds of video to avoid this issue before recording the time-lapse.

## Installation
* In /home/pi create a directory named _wx_video_
* Make sure _/var/www/html/wx_ exists and the current user has read and write permission
* Place the three shell scripts and the video.py script in that directory
* Run _crontab -e_ and place the final three lines from _crontab.txt_ into the crontab
