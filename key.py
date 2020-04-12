from pynput import keyboard
import relay24

with keyboard.GlobalHotKeys({
        'h': relay24.on,
        'i': relay24.off})as h:
    h.join()



# from gpiozero import Button, LED
# from pynput import keyboard
# from signal import pause
# import os

# btn1 = Button(21, hold_time=1)
# led1 = LED(26)
# led1.on()

# def Repeater():
#     os.system("sudo create_ap wlx00117f03799e wlan0 Raspi miragedz123")

# def start():
#     os.system("sudo python3 /home/pi/gpio/relay24.py start")

# def stop():
#     os.system("sudo python3 /home/pi/gpio/relay24.py stop")



# btn1.when_pressed = start
# btn1.when_held = stop

# with keyboard.GlobalHotKeys({
#         'h': start,
#         'i': stop}) as h:
#     h.join()

# pause()
