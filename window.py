import numpy as np
import cv2
import time
import os
import sys

loadImage = True

refPoint = [-1,-1]
touchdown = False

def mouse_left(event, x, y, flags, param):
    global refPt, touchdown

    if event == cv2.EVENT_LBUTTONDOWN:
        print "click"
        refPoint = [x, y]
        touchdown = True
    elif event == cv2.EVENT_MOUSEMOVE:
        print "move"
        refPoint = [x, y]
    elif event == cv2.EVENT_LBUTTONUP:
        print "lift"
        refPoint = [-1,-1]
        touchdown = False

identity = "Hackweek"
width = 400
height = 400
print sys.argv
if len(sys.argv) >= 2:
    identity = sys.argv[1]
    width = sys.argv[2]
    height = sys.argv[3]

cv2.namedWindow(identity, cv2.WINDOW_NORMAL)
cv2.setMouseCallback(identity, mouse_left)

here = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))

while (loadImage):
    try:
        # capture cursor info
        if touchdown:
            if refPoint[0] > -1:
                pointerBuffer = open(os.path.join(here, identity + '.jpg'), 'w')
                #f.seek(0)
                pointerBuffer.write(str(refPoint[0]) + "," + str(refPoint[1] + ","))
                pointerBuffer.close()
        refPoint = [-1, -1]
    except:
        print "gesture exception"

    try:

        img = cv2.imread(identity + '.jpeg', 1)
        print type(img)
        if type(img) is None:
            time.sleep(0.1)
            cv2.waitKey(100)
            continue
        height, width = img.shape[:2]
        if width > 0:
            cv2.imshow(identity,img)
            print "read image"
            try:
                os.remove(identity + ".jpeg")
            except:
                print "failed to remove image </3"

        time.sleep(0.1)
        cv2.waitKey(100)
    except:
        print "nException </3"
        time.sleep(0.1)
        cv2.waitKey(100)
