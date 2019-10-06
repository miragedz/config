#!/bin/bash
 
# Disk usage - Show or hide virtual mountpoints (tmpfs)
DISK_SHOW_TMPFS=false
 
# Service who returns WAN IP
GET_WAN_IP="https://www.ezservermonitor.com/myip"
 
# Hosts to ping
PING_HOSTS=("google.com" "facebook.com" "yahoo.com")
 
SERVICES_NAME[445]="SAMBA Server"
SERVICES_HOST[445]="localhost"
 
SERVICES_NAME[22]="SSH"
SERVICES_HOST[22]="localhost"
 
SERVICES_NAME[80]="Web Server"
SERVICES_HOST[80]="localhost"
 
SERVICES_NAME[8765]="MotionEYE"
SERVICES_HOST[8765]="localhost"

SERVICES_NAME[5900]="VNC Server"
SERVICES_HOST[5900]="localhost"


# Text color : RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE
THEME_TEXT=GREEN

# Title color : WHITE_ON_GREY, WHITE_ON_RED, WHITE_ON_GREEN, WHITE_ON_BLUE, WHITE_ON_MAGENTA, WHITE_ON_CYAN, BLACK_ON_YELLOW
THEME_TITLE=WHITE_ON_GREY
 
 
# ********************************************************** #
# *                        [ VARS ]                        * #
# ********************************************************** #
 
# Constants -- DON'T TOUCH !!
ESM_NAME="eZ Server Monitor \`sh"
ESM_VERSION="2.3"
ESM_AUTHOR="ShevAbam"
ESM_CREATED="30 nov. 2017"
ESM_URL="https://www.ezservermonitor.com"
 
# Colors
NC="\e[0m"
RED="\e[31;40m"
GREEN="\e[32;40m"
YELLOW="\e[33;40m"
BLUE="\e[34;40m"
MAGENTA="\e[35;40m"
CYAN="\e[36;40m"
WHITE="\e[37;40m"
 
# Styles
BOLD="\e[1m"
RESET="\e[0m"
WHITE_ON_GREY="\e[100;97m"
WHITE_ON_RED="\e[41;37m"
WHITE_ON_GREEN="\e[42;37m"
WHITE_ON_BLUE="\e[104;37m"
WHITE_ON_MAGENTA="\e[45;37m"
WHITE_ON_CYAN="\e[46;37m"
BLACK_ON_YELLOW="\e[103;30m"
 
 
# *************************************************************** #
# *                        [ FUNCTIONS ]                        * #
# *************************************************************** #

# Function : network
function network()
{
    INTERFACES=`/sbin/ifconfig |awk -F '[/  |: ]' '{print $1}' |sed -e '/^$/d'`
 
    if [ -e "/usr/bin/curl" ] ; then
        IP_WAN=`curl -s ${GET_WAN_IP}`
    else
        IP_WAN=`wget ${GET_WAN_IP} -O - -o /dev/null`
    fi
 
    echo "Network"
 
    for INTERFACE in $INTERFACES
    do
        IP_LAN=`/sbin/ip -f inet -o addr show ${INTERFACE} | cut -d\  -f 7 | cut -d/ -f 1`
        echo -e "${!THEME_TEXT}  IP LAN (${INTERFACE}) ${WHITE}$IP_LAN"
    done
 
    echo -e "${!THEME_TEXT}  IP WAN\t ${WHITE}$IP_WAN"
}
 
# Function : ping
function ping()
{
    echo "Ping"
 
    for HOST in ${PING_HOSTS[@]}
    do
        PING=`/bin/ping -qc 1 $HOST | awk -F/ '/^(rtt|round-trip)/ { print $5 }'`
 
        echo -e "${!THEME_TEXT}  ${HOST}\t ${WHITE}$PING ms"
    done
}
 
# Function : Disk space  (top 5)
function disk_space()
{
    HDD_TOP=`df -h | head -1 | sed s/^/"  "/`
    #HDD_DATA=`df -hl | grep -v "^Filesystem" | grep -v "^Sys. de fich." | sort -k5r | head -5 | sed s/^/"  "/`
    # HDD_DATA=`df -hl | sed "1 d" | grep -v "^Filesystem" | grep -v "^Sys. de fich." | sort | head -5 | sed s/^/"  "/`
 
    if [ ${DISK_SHOW_TMPFS} = true ] ; then
        HDD_DATA=`df -hl | sed "1 d" | grep -iv "^Filesystem|Sys." | sort | head -5 | sed s/^/"  "/`
    else
        HDD_DATA=`df -hl | sed "1 d" | grep -iv "^Filesystem|Sys." | grep -vE "^tmpfs|udev" | sort | head -5 | sed s/^/"  "/`
    fi
 
    echo "Disk space (top 5)" 
    echo -e "${!THEME_TEXT}$HDD_TOP"
    echo -e "${WHITE}$HDD_DATA"
}
 
# Function : services
function services()
{
    echo "Services"
 
    for PORT in "${!SERVICES_NAME[@]}"
    do
        NAME=${SERVICES_NAME[$PORT]}
        HOST=${SERVICES_HOST[$PORT]}
 
        CHECK=`(exec 3<>/dev/tcp/$HOST/$PORT) &>/dev/null; echo $?`
 
        if [ $CHECK = 0 ] ; then
            CHECK_LABEL=${WHITE}ONLINE
        else
            CHECK_LABEL=${RED}OFFLINE
        fi
 
        echo -e "${!THEME_TEXT}  $NAME ($PORT) : ${CHECK_LABEL}"
    done
}
 
# Function : showAll
function showAll()
{
    network
    ping
    disk_space
    services
    system_temperatures
}

# *************************************************************** #
# *                       [ LET'S GO !! ]                       * #
# *************************************************************** #
 
if [ $# -ge 1 ] ; then
   
    while getopts "Csenpcmltdavhu-:" option
    do
        case $option in
            h | u) showHelp; exit ;;
            v) showVersion; exit;;
            C) clear ;;
            n) network ;;
            p) ping ;;
            c) cpu ;;
            m) memory ;;
            l) load_average ;;
            d) disk_space ;;
            s) services ;;
            a) showAll ;;
            -) case $OPTARG in
                  all) showAll; exit ;;
                  clear) clear ;;
                  system) system ;;
                  services) services ;;
                  load) load_average ;;
                  cpu) cpu ;;
                  memory) memory ;;
                  network) network ;;
                  ping) ping ;;
                  disk) disk_space ;;
                  *) exit ;;
               esac ;;
            ?) echo "Option -$OPTARG inconnue"; exit ;;
            *) exit ;;
        esac
    done
fi
