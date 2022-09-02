#!/usr/bin/python3

# a filesorter to sort all incoming files to ~/Downloads
import shutil
import os

os.chdir("/home/eike/Downloads")
for file in os.listdir():
    if os.path.isdir("/home/eike/Downloads/" + file):
        continue
    if not os.path.isdir("/home/eike/Downloads/"+os.path.splitext(file)[1][1:]):
        os.mkdir("/home/eike/Downloads/"+os.path.splitext(file)[1][1:])
        print(os.path.splitext(file)[1][1:]+" created")
        shutil.move("/home/eike/Downloads/"+file, "/home/eike/Downloads/"+os.path.splitext(file)[1][1:]+"/"+file)
        print(file + " moved to " + os.path.splitext(file)[1][1:])
    else:
        shutil.move("/home/eike/Downloads/"+file, "/home/eike/Downloads/"+os.path.splitext(file)[1][1:]+"/"+file)
        print(file + " moved to " + os.path.splitext(file)[1][1:])
