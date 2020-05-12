from relay24 import state
import readchar, os

def main():
        x=1
        while True:
            print ("up or down key , enter for exit\n or other key for detected")
            # Read a key
            key = readchar.readkey()
            if(key == '\r'):
                if x==1:
                   state(sts="start")
                   x=0
                else:
                   state(sts="stop")
                   x=1
            elif(key == '\x1b[B'):#key ENTER
                quit()
            else:
                pass

if __name__ == "__main__":
        main()

#keys: up:x1b[A , down : \x1b[B ,  left ; \x1b[D ,  right; \x1b[C ,  ENTER : \r , ESC : \x1b\x1b , 



import relay24 
import readchar, os

# TextColour BlackBackground           
green='\033[1;32;40m'         
yellow='\033[1;33;40m'
cyan='\033[1;36;40m'
bg='\033[0;37;44m' #WhiteText ColouredBackground
def main():
        x=1
        while True:
            print (bg+"\t\tMirage Studio"+green+"\nup or down key \t\tenter for exit"+yellow+"\nor other key\t\tfor detected")
            # Read a key
            key = readchar.readkey()
            if(key == '\r'):
                if x==1:
                   relay24.state(sts="start")
                   x=0
                else:
                   relay24.state(sts="stop")
                   x=1
            elif(key == '\x1b[B'):
                os.system('clear')
                quit()
            else:
                pass

if __name__ == "__main__":
  try:
     main()
  except KeyboardInterrupt:
    print(" Shutting down server.")
    exit()
       

#keys: up:x1b[A , down : \x1b[B ,  left ; \x1b[D ,  right; \x1b[C ,  ENTER : \r , ESC : \x1b\x1b , 




