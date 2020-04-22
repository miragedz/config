from getkey import getkey, keys
from signal import pause


x = True
while True:
    key = getkey()
    
    if key == keys.ENTER and x == True:
        print("ENTER!")
        x = not x 
    else:
        print("ok!")
        x = not x

pause()
