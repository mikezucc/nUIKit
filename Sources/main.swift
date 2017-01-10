// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import swiftgd

let player = ["rock", "paper", "scissors", "lizard", "spock"]

srandom(UInt32(NSDate().timeIntervalSince1970))
for count in 1...3 {
  DispatchQueue.main.async {
    print(count)
  }
  sleep(1)
}

func shell(launchPath: String, arguments: [String]) -> String
{
  let task = Task()
  task.launchPath = launchPath
  task.arguments = arguments

  let pipe = Pipe()
  task.standardOutput = pipe
  task.launch()

  let data = pipe.fileHandleForReading.readDataToEndOfFile()
  // NSUTF8StringEncoding
  guard let output: String = String(data: data, encoding: String.Encoding(rawValue: 4)) else {
    return "-1"
  }

  return output
}

print(player[random() % player.count])

let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
let destination = currentDirectory.appendingPathComponent("memes2.jpeg")

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
