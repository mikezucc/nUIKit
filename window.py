import numpy as np
import cv2
import time
import os

loadImage = True
cv2.namedWindow('runna', cv2.WINDOW_NORMAL)

while (loadImage):
    try:
        img = cv2.imread('memes2.jpeg',1)
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
                os.remove("memes2.jpeg")
            except:
                print "failed to remove image"
        time.sleep(0.1)
        cv2.waitKey(1)
    except:
        time.sleep(0.1)
        cv2.waitKey(100)
