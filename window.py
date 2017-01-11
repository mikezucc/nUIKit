import numpy as np
import cv2
import time
import os
import sys

loadImage = True

identity = "Application"
width = 50
height = 50
print sys.argv
if len(sys.argv) >= 1:
    identity = sys.argv[1]
    width = sys.argv[2]
    height = sys.argv[3]

cv2.namedWindow(identity, cv2.WINDOW_NORMAL)

while (loadImage):
    try:
        img = cv2.imread(identity + '.jpeg', 1)
        print type(img)
        if type(img) is None:
            time.sleep(0.1)
            cv2.waitKey(100)
            continue
        height, width = img.shape[:2]
        if width > 0:
            cv2.imshow('runna',img)
            print "read image"
            try:
                os.remove(identity + ".jpeg")
            except:
                print "failed to remove image </3"
        time.sleep(0.1)
        cv2.waitKey(1)
    except:
        print "nException </3"
        time.sleep(0.1)
        cv2.waitKey(100)
