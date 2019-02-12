# wx_video
Collects time-lapse GIF and MP4 videos using Raspberry Pi and the Pi Camera. I use it to capture the sky/weather

Time-lapse Video Project

This project was created in order to collect time-lapse videos of the sky outside my house on a continuous basis (24/7). It could be used to collect time-lapse video of anything but this is the purpose for which it was built.

Required Hardware
* Raspberry Pi with WiFi or Ethernet (I used a Pi B+ with a TP-Link WiFi adapter)
* Raspberry Pi camera (I used a V1 camera but V2 should work as well)
* Micro SD card (I started with an 8GB card but it wasn't large enough. 16GB would have worked but I had a 32GB handy and used that)

You should have a web server configured as well as having enabled the camera. I find it easiest to work with the Pi over SSH rather than using a display+keyboard+mouse. If you feel the same you will also need to enable SSH access.
------> Add a link to the RPi page on how to connect and test the camera
-----> The Pi webserver is assumed to store it's files in /var/www/html. The "wx" directory needs to be created within that directory. 

Software Components
* A crontab entry for root ("sudo crontab -e") to launch the necessary scripts on a schedule
* Three shell scripts
* capture_wx.sh - captures a series of GIF images then combines them into an animated GIF and calls video.py to create a separate MP4 time-lapse
* compile_wx.sh - runs once an hour and combines the previous hour's MP4 time-lapse into a single file
* delete_wx.sh - runs once a day and deletes the video files created 2 days prior
* One Python script
* video.py - records time-lapse in MP4, called from capture_wx.sh

