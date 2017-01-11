// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import swiftgd

class Window {

  // window name
  var identity = "Application"
  let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
  var displayBuffer = ""

  // top most view controller should be in the back
  var controllers = [ViewController]()
  var windowSize = CGSize(width: 0, height: 0)

  // only this one is done async, rest of ignites are done sync
  func ignite() {
    DispatchQueue.main.async {
      while true {
        let masterImage = Image(width: windowSize.width, height: windowSize.height)
        for view in subviews {
          let renderedSubview = view.ignite()
          let usableBoundWidth = frame.width - view.frame.x
          let usableBoundHeight = frame.height - view.frame.y
          for x in 0...usableBoundWidth {
            for y in 0...usableBoundHeight {
              let pixelColor = renderedSubview.get(pixel: Point(x: x, y: y))
              masterImage.set(pixel: Point(x: x + view.frame.x, y: y + view.frame.y), to: pixelColor)
            }
          }
        }
        masterImage.write(to: displayBuffer)
        // pause for 300ms
        usleep(1000 * 300)
      }
    }
  }

  func init(identity: String, size: CGSize) {
    shell("python window.py", identity, "\(size.width)", "\(size.height)")
    windowSize = size
    self.identity = identity
    displayBuffer = currentDirectory.appendingPathComponent("\(identity).jpeg")
  }

  // http://stackoverflow.com/a/26973384
  @discardableResult
  func shell(_ args: String...) -> Int32 {
      let task = Process()
      task.launchPath = "/usr/bin/env"
      task.arguments = args
      task.launch()
      task.waitUntilExit()
      return task.terminationStatus
  }

}
