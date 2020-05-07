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



