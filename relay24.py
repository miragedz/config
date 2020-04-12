#!/bin/python3

import RPi.GPIO as GPIO
import sys

GPIO.setmode(GPIO.BCM)

def on():
	GPIO.setup(24, GPIO.OUT)
def off():
	GPIO.setup(24, GPIO.IN)


def main():
	action = sys.argv[1]

	if len (sys.argv) != 2 :
	    print ("one argument please ")
	    sys.exit (1)
	else:
		if action == "start" :
			on()
		elif action == "stop" :
			off()
		else:
			print ("start/stop")
	
if __name__ == "__main__":
	main()			