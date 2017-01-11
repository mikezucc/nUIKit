// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import swiftgd

// attempt to create a new 500x500 image
let image = Image(width: 500, height: 500)
var rVal: Double = 0
var gVal: Double = 0
var bVal: Double = 0
while let _ = image {
    print("made image")
    // flood from from X:250 Y:250 using red
    image?.fill(from: Point(x: 250, y: 250), color: Color.red)

    // draw a filled blue ellipse in the center
    image?.fillEllipse(center: Point(x: 250, y: 250), size: Size(width: 150, height: 150), color: Color(red: rVal, green: gVal, blue: bVal, alpha: 1))

    // draw a filled green rectangle also in the center
    image?.fillRectangle(topLeft: Point(x: 200, y: 200), bottomRight: Point(x: 300, y: 300), color: Color(red: rVal, green: gVal, blue: bVal, alpha: 1))

    // remove all the colors from the image
    image?.desaturate()

    // now apply a dark red tint
    rVal = (rVal + Double(random())/10.0).truncatingRemainder(dividingBy: 1.0)
    gVal = (gVal + Double(random())/10.0).truncatingRemainder(dividingBy: 1.0)
    bVal = (bVal + Double(random())/10.0).truncatingRemainder(dividingBy: 1.0)
    print(rVal)
    print(gVal)
    print(bVal)
    print("---")
    //image?.colorize(using: Color(red: rVal, green: gVal, blue: bVal, alpha: 1))

    // save the final image to disk
    image?.write(to: destination)
    usleep(1000 * 300)
}
