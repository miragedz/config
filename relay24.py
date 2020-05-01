#!/bin/python3

def other():
	print ("start / stop ")
	sys.exit (1)

def state(sts):
	import RPi.GPIO as GPIO
	GPIO.setmode(GPIO.BCM)
	if sts == "start" :
		GPIO.setup(15, GPIO.OUT)
	elif sts == "stop" :
		GPIO.setup(15, GPIO.IN)
		GPIO.cleanup()
	else:
		print ("start / stop")

def main():
	import sys
	sts = sys.argv[1]
	ln = len (sys.argv)
	if ln == 2 :
		state(sts)
	else:
		other()

if __name__ == "__main__":
    try:
        main()
    except:
        print("offfff")		
