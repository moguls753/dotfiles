#!/bin/sh

connected=$(xrandr -q | awk '/ connected/ {print $1}' | wc -l)
if [ $connected -eq 2 ]
#if [ (2) -eq 1 ]
then
    external=$(xrandr -q | awk '/ connected/ {print $1}' | awk 'FNR == 2 {print}')
    xrandr --output eDP --mode 2240x1400 --pos 0x1097 --rotate normal --output DisplayPort-0 --off --output DisplayPort-1 --off --output DisplayPort-2 --off --output DisplayPort-0 --off --output DisplayPort-3 --primary --mode 3840x2160 --pos 2240x0 --rotate normal
fi
