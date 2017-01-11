# nUIKit
UIKit for Swift 3 on Linux

Dependencies:

Python 2.7 plus random packages

https://swift.org/download/ or https://github.com/apple/swift

In terminal, `nano ~/.bashrc` and paste at the end `export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first`. Make sure to copy the Swift 3 directory to `~/` first and then rename the top level folder to swift3

If you have trouble, go to the Linux section on here https://swift.org/download/#using-downloads

If you get SwiftGD faults when trying to read local files, i.e. images, please run this in top level `sudo chmod -R +r *` and also in the top level of your swift3 dir

https://github.com/twostraws/SwiftGD

This guy needs a `sudo apt-get libgd-dev`

https://github.com/Itseez/opencv

### OpenCV 3.0.0 install instructions

http://www.pyimagesearch.com/2015/06/22/install-opencv-3-0-and-python-2-7-on-ubuntu/

## How to Run:

1. In top level, run `swift build`
2. Previous command should output a build path like `Linking /home/honey/Documents/nUIKit/.build/debug/nUIKit`
3. paste build to run i.e. `$ ./.build/debug/nUIKit`

# Runtime Structure

Swift runs separately from python which will be the display and interaction. One can fail and the other will continue. Need to run the shell from the swift main.

window.py creates the window upon which all `Application`s are rendered to using OpenCV

`Application` is created with a `Window`

`Window` is created with an InitialViewController of type `ViewController`, `Window` can have array of top level `ViewController`s (extends past UIWindow constraint)

`ViewController` has a main View, and can own an array of child `ViewController`

`View` can have subviews of `View`

## Render loop

1. `Application` calls `ignite()` on its main `Window`
2. Window's `ignite()` calls the `ignite()` of the top level `ViewController`s
3. This begins a recursive ignition loop on that `ViewController`s `view`by having it ask each of it's subviews to `ignite()` as well 
4. This returns the rendered `Image` for that particular top level view controller 
5. The Window then combines all of the top level `ViewController`s rendered `Image`s into one `Image`
6. The `Image` is then written to a buffer file with the application name `Hackweek.jpeg`. 
7. Python `window.py` displays it to cv named window
