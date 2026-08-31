#!/bin/bash

case "$1" in
    on|ON)
        echo "Activating Raspi AP..."
        sudo nmcli device disconnect wlan0 && sudo nmcli device connect wlan0 && sudo nmcli con up Hotspot0
        ;;

    off|OFF)
        echo "disconecting Raspi AP..."
        sudo nmcli con down Hotspot0 
        ;;
esac
