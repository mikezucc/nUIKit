# nUIKit
UIKit for Swift 3 on Linux

Dependencies:

https://github.com/twostraws/SwiftGD

https://github.com/Itseez/opencv

### OpenCV 3.0.0 install instructions

http://www.pyimagesearch.com/2015/06/22/install-opencv-3-0-and-python-2-7-on-ubuntu/

## How to Run:

1. Donwload prebuilts https://swift.org/download/ or build from source https://github.com/apple/swift
2. Clone this Repo
3. In top level, run `swift build`
4. Previous command should output a build path like `Linking /home/honey/Documents/nUIKit/.build/debug/nUIKit`
5. paste build to run i.e. `$ ./.build/debug/nUIKit`

# Runtime Structure

Swift is the runtime for creating rendered views which OpenCV 3 Python 2.7 is in charge of displaying and mediating interaction

window.py creates the window upon which all `Application`s are rendered to using OpenCV

`Application` is created with a `Window`

`Window` is created with an InitialViewController of type `ViewController`, `Window` can have array of top level `ViewController`s

`ViewController` has a main View, and can own an array of child `ViewController`

`View` can have subviews of `View`

## Render loop

`Application` calls `ignite()` on its main `Window`. Window's `ignite()` calls the `ignite()` of the top level `ViewController`s. This begins a recursive ignition loop on that `ViewController`s `view`by having it ask each of it's subviews to `ignite()` as well. This returns the rendered `Image` for that particular top level view controller. The Window then combines all of the top level `ViewController`s rendered `Image`s into one `Image`. The `Image` is then written to a buffer file with the application name `Hackweek.jpeg`. 
