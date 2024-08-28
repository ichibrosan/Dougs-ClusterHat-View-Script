#!/bin/bash

# Get screen dimensions
SCREEN_WIDTH=$(xdpyinfo | grep dimensions | awk '{print $2}' | cut -d 'x' -f 1)
SCREEN_HEIGHT=$(xdpyinfo | grep dimensions | awk '{print $2}' | cut -d 'x' -f 2)

# Set xterm window dimensions (width and height)
# Adjust these values as needed
WIN_WIDTH=$((SCREEN_WIDTH / 2))
WIN_HEIGHT=$((SCREEN_HEIGHT / 3))

COLOR1=DarkCyan
COLOR2=DarkGreen
COLOR3=DarkGoldenrod
COLOR4=DarkMagenta
COLOR5=DarkBlue
COLOR6=DarkOliveGreen

P1VP=30
P1HP=30
P2VP=30
P2HP=$((WIN_WIDTH))
P3VP=$((WIN_HEIGHT))
P3HP=30
P4VP=$((WIN_HEIGHT))
P4HP=$((WIN_WIDTH))
P5VP=$((WIN_HEIGHT*2-30))
P5HP=30
P6VP=$((WIN_HEIGHT*2-30))
P6HP=$((WIN_WIDTH))

VCHARS=25
HCHARS=144
GEOM1=$((HCHARS))x$((VCHARS))+$((P1HP))+$((P1VP))
GEOM2=$((HCHARS))x$((VCHARS))+$((P2HP))+$((P2VP))
GEOM3=$((HCHARS))x$((VCHARS))+$((P3HP))+$((P3VP))
GEOM4=$((HCHARS))x$((VCHARS))+$((P4HP))+$((P4VP))
GEOM5=$((HCHARS))x$((VCHARS))+$((P5HP))+$((P5VP))
GEOM6=$((HCHARS))x$((VCHARS))+$((P6HP))+$((P6VP))


FS=11

xterm -fg white -bg $COLOR1 -fa 'Monospace' -fs $FS -geometry $GEOM1 -e "ssh userp1@192.168.4.251" &
xterm -fg white -bg $COLOR2 -fa 'Monospace' -fs $FS -geometry $GEOM2 -e "ssh userp2@192.168.4.251" &
xterm -fg white -bg $COLOR3 -fa 'Monospace' -fs $FS -geometry $GEOM3 -e "ssh userp3@192.168.4.251" &
xterm -fg white -bg $COLOR4 -fa 'Monospace' -fs $FS -geometry $GEOM4 -e "ssh userp4@192.168.4.251" &
xterm -fg white -bg $COLOR5 -fa 'Monospace' -fs $FS -geometry $GEOM5 -e "ssh doug@192.168.4.251"   &
xterm -fg white -bg $COLOR6 -fa 'Monospace' -fs $FS -geometry $GEOM6                               &
