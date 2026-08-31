#!/usr/bin/env bash
set -euo pipefail 
  
case "${1:-}" in 
    on|activate|start)
echo "Activating Raspberry Pi Desktop..." 
sudo systemctl set-default graphical.target 
sudo systemctl isolate graphical.target
        ;;
    off|deactivate|stop) 
echo "Deactivating Raspberry Pi Desktop..." 
sudo systemctl set-default multi-user.target 
sudo systemctl isolate multi-user.target
        ;;
    status) systemctl get-default
        ;;
    *) echo "Usage: $0 {on|off|status}" exit 1
        ;;
esac
