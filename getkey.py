from relay24 import state
import readchar

def main():
        while True:
            print ("up or down key , enter for exit\n other key for detected")
            # Read a key
            key = readchar.readkey()
            if(key == '\x1b[A'): 
                state(sts="start")
                print(key)
            elif(key == '\x1b[B'): #key down
                state(sts="stop")
                print(key)
            elif(key == '\r'):#key ENTER
                quit()
            else:
                key_detect() 
def key_detect():
    while True:
        print("Reading a key:")
        print(repr(readchar.readkey())) 

if __name__ == "__main__":
        main()

#keys: up:x1b[A , down : \x1b[B ,  left ; \x1b[D ,  right; \x1b[C ,  ENTER : \r , ESC : \x1b\x1b , 
