// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

enum TouchPhase {
  case None
  case Started
  case Moving
}

class Window {

  // window name
  var identity = "Application"
  let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
  var displayBuffer: URL?

  // top most view controller should be in the back
  var controllers = [ViewController]()
  var windowSize = nCGRect(x: 0, y: 0, width: 0, height: 0)

  let initialController = InitialViewController()

  // touchdown
  var lastKnownPoint = Point(x: 0, y: 0)
  var phase = TouchPhase.None


  // only this one is done async, rest of ignites are done sync
  func ignite() {
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

  func touched(point: Point) {
    if self.phase == .None {
      self.phase = .Started
    } else if self.phase == .Started {
      self.phase = .Moving
    }

    self.lastKnownPoint = Point(x: point.x, y: point.y)

    for controller in controllers {
      // manual override for the desperate

      // put logic to prevent other controllers from receiving the event once they are engaged, or leave it to act like a magnet, and have the click down motion fan out the different windows. could be an intuitive way to organize things
      if controller.thisIsMyTouch(point: point) {
        continue
      }
      if let view = controller.view {
      // > x v y  coordinate system
        if view.frame.x >= point.x && view.frame.y >= point.y && point.x  <= view.frame.width + view.frame.x && point.y <= view.frame.height + view.frame.y {
          if self.phase == .Started {
            controller.touchBegan(point: Point(x: view.frame.x - point.x, y: view.frame.y - point.y ))
          } else if self.phase == .Moving {
            controller.touchMoved(point: Point(x: view.frame.x - point.x, y: view.frame.y - point.y ))
          }
        }
      }
    }
  }

  func touchLifted() {
    self.phase = .None
    for controller in controllers {
      // manual override for the desperate
      if controller.thisIsMyTouch(point: Point(x: 0, y: 0)) {
        continue
      }
      if let view = controller.view {
      // > x v y  coordinate system
        if view.frame.x >= self.lastKnownPoint.x && view.frame.y >= self.lastKnownPoint.y && self.lastKnownPoint.x  <= view.frame.width + view.frame.x && self.lastKnownPoint.y <= view.frame.height + view.frame.y {
          controller.touchEnded(point: Point(x: view.frame.x - self.lastKnownPoint.x, y: view.frame.y - self.lastKnownPoint.y ))
        }
      }
    }
  }

  init(identity: String, rect: nCGRect) {
    shell(path: "python window.py", name: identity, arg1: "\(rect.width)", arg2: "\(rect.height)")
    self.windowSize = rect
    self.identity = identity
    self.displayBuffer = currentDirectory.appendingPathComponent("\(identity).jpeg")
    self.controllers.append(self.initialController)
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
