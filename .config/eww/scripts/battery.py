#!/usr/bin/env python3

import psutil
import argparse
import subprocess


def secs2hours(secs):
    mm, ss = divmod(secs, 60)
    hh, mm = divmod(mm, 60)
    return "%d:%02d:%02d" % (hh, mm, ss)


parser = argparse.ArgumentParser()
parser.add_argument('--c',
                    choices=('icon', 'left-click', 'digit'),
                    dest='command',
                    default='icon',
                    help='Allowed values are status, left-click and digit'
                    )
args = parser.parse_args()

battery = psutil.sensors_battery()
icon = ""
percent = int(battery.percent)
time_left = battery.secsleft
isPlugged = battery.power_plugged
remaining = secs2hours(time_left)

if args.command == "digit":
        message = str(percent) + "%"
        print(message, end="")
if args.command == "icon":
    if isPlugged:
        if percent == 100:
            icon = "󰂅"
        elif percent > 89 and percent < 100:
            icon = "󰂋"
        elif percent > 79 and percent < 90:
            icon = "󰂊"
        elif percent > 69 and percent < 80:
            icon = "󰢞"
        elif percent > 59 and percent < 70:
            icon = "󰂉"
        elif percent > 49 and percent < 60:
            icon = "󰢝"
        elif percent > 39 and percent < 50:
            icon = "󰂈"
        elif percent > 29 and percent < 40:
            icon = "󰂇"
        elif percent > 19 and percent < 30:
            icon = "󰂆"
        elif percent > 9 and percent < 20:
            icon = "󰢜"
        elif percent > 0 and percent < 10:
            icon = "󰢟"
        print(icon, end="")
    else:
        if percent == 100:
            icon = ""
        elif percent > 89 and percent < 100:
            icon = "󰂂"
        elif percent > 79 and percent < 90:
            icon = "󰂁"
        elif percent > 69 and percent < 80:
            icon = "󰂀"
        elif percent > 59 and percent < 70:
            icon = "󰁿"
        elif percent > 49 and percent < 60:
            icon = "󰁾"
        elif percent > 39 and percent < 50:
            icon = "󰁽"
        elif percent > 29 and percent < 40:
            icon = "󰁼"
        elif percent > 19 and percent < 30:
            icon = "󰁻"
        elif percent > 9 and percent < 20:
            icon = "󰁺"
        elif percent > 0 and percent < 10:
            icon = "󱃍"
        print(icon, end="")
if args.command == "left-click":
    if not isPlugged:
        subprocess.call(["notify-send", "-r", "55555", "-u", "normal", "Est remaining time left: " + remaining])
    else:
        subprocess.call(["notify-send", "-r", "55555", "-u", "normal", str(percent) + "% Charged"])
