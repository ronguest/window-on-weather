from time import sleep
import picamera

camera = picamera.PiCamera()
#camera.resolution = (1280, 720)
camera.resolution = (960, 540)
camera.framerate = 15
# First few seconds are blown out as auto-exposure kicks in, so record a dummy first.
camera.start_recording('trash.h264')
camera.wait_recording(5)
camera.stop_recording()

camera.framerate = 2
camera.start_recording('test.h264')
camera.wait_recording(140)
camera.stop_recording()
