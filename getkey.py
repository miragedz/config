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

# ---------------------------------------------------------------------------
#        KEY_BREAK            Break key
#        KEY_DOWN             The four arrow keys ...
#        KEY_UP
#        KEY_LEFT
#        KEY_RIGHT
#        KEY_HOME             Home key (upward+left arrow)
#        KEY_BACKSPACE        Backspace
#        KEY_F0               Function keys; space for 64 keys is reserved.
#        KEY_F(n)             For 0<n < 63
#        KEY_DL               Delete line
#        KEY_IL               Insert line
#        KEY_DC               Delete character
#        KEY_IC               Insert char or enter insert mode
#        KEY_EIC              Exit insert char mode
#        KEY_CLEAR            Clear screen
#        KEY_EOS              Clear to end of screen
#        KEY_EOL              Clear to end of line
#        KEY_SF               Scroll 1 line forward
#        KEY_SR               Scroll 1 line backward (reverse)
#        KEY_NPAGE            Next page
#        KEY_PPAGE            Previous page
#        KEY_STAB             Set tab
#        KEY_CTAB             Clear tab
#        KEY_CATAB            Clear all tabs
#        KEY_ENTER            Enter or send
#        KEY_SRESET           Soft (partial) reset
#        KEY_RESET            Reset or hard reset
#        KEY_PRINT            Print or copy
#        KEY_LL               Home down or bottom (lower left).  Keypad is
