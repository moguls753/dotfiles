#!/bin/sh

connected=$(xrandr -q | awk '/ connected/ {print $1}' | wc -l)
if [ $connected -eq 2 ]
#if [ (2) -eq 1 ]
then
    external=$(xrandr -q | awk '/ connected/ {print $1}' | awk 'FNR == 2 {print}')
    xrandr --output eDP --off --output $external --auto
fi
