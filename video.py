from time import sleep
import picamera

camera = picamera.PiCamera()
camera.resolution = (1280, 720)
camera.framerate = 2
camera.start_preview()
# Camera warm-up time
sleep(5)
camera.start_recording('test.h264')
camera.wait_recording(140)
camera.stop_recording()
