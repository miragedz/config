import curses, os
stdscr = curses.initscr()
curses.cbreak()
stdscr.keypad(1)
while True:
    c = stdscr.getch()
    if c == ord('q'):
        break 
    elif c == curses.KEY_UP:
        os.system("python3 /home/pi/gpio/relay24.py start")
    elif c == curses.KEY_DOWN:
        os.system("python3 /home/pi/gpio/relay24.py stop")
    elif c == ord('o'):
        os.system("python3 /home/pi/gpio/relay24.py stop")
