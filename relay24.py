def other():
	print ("start / stop ")
	sys.exit (1)

def state(sts):
	import os
	if sts == "start" :
		os.system('pigs m 15 w')
	elif sts == "stop" :
		os.system('pigs m 15 r')
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

