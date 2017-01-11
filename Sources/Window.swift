// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import swiftgd

class Window {

  // window name
  var identity = "Application"
  let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
  var displayBuffer: URL?

  // top most view controller should be in the back
  var controllers = [ViewController]()
  var windowSize = nCGRect(x: 0, y: 0, width: 0, height: 0)

  let initialController = InitialViewController()
  let initialController2 = InitialViewController()

  // only this one is done async, rest of ignites are done sync
  func ignite() {
    print("** IGNITING FOR WINDOW: \(identity)")
    while true {
      if let masterImage = Image(width: self.windowSize.width, height: self.windowSize.height) {
        print("Generate clean frame buffer")
        for controller in self.controllers {
          print("\t\tloading controller \(controller)")
          if let view = controller.view {
            print("\t\tBegin render for view \(view)")
            if let renderedSubview = controller.ignite() {
              let usableBoundWidth = self.windowSize.width - view.frame.x
              let usableBoundHeight = self.windowSize.height - view.frame.y
              print("\t\tIgnited view \(view) with bounds \(usableBoundWidth) x \(usableBoundHeight) from point \(view.frame.x)")
              for x in 0...usableBoundWidth {
                for y in 0...usableBoundHeight {
                  let pixelColor = renderedSubview.get(pixel: Point(x: x, y: y))
                  masterImage.set(pixel: Point(x: x + view.frame.x, y: y + view.frame.y), to: pixelColor)
                }
              }
            }
          }
        }
        if let buffer = self.displayBuffer {
          print("\tWriting frame buffer")
          masterImage.write(to: buffer)
        }
      }
      print("\tEnd frame buffer")
      // pause for 300ms
      usleep(1000 * 300)
    }
  }

  init(identity: String, rect: nCGRect) {
    shell(path: "python window.py", name: identity, arg1: "\(rect.width)", arg2: "\(rect.height)")
    self.windowSize = rect
    self.identity = identity
    self.displayBuffer = currentDirectory.appendingPathComponent("\(identity).jpeg")
    self.controllers.append(self.initialController)
    self.initialController2.view?.frame.y = 300
    self.controllers.append(self.initialController2)
  }

  // http://stackoverflow.com/a/26973384
  @discardableResult
  func shell(path: String, name: String, arg1: String, arg2: String) {
    let task = Task()
    task.launchPath = path
    task.arguments = [name, arg1, arg2]

    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
  }

}
