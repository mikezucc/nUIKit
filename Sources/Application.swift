// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class Application {

  let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
  var pointerBuffer: URL?

  var windows = [String: Window]()

  let windowSize = nCGRect(x:0, y:0, width: 400, height: 400)

  init?(name: String) {
    // default root window
    let window = Window(identity: name, rect: windowSize)
    windows = [name: window]

    self.pointerBuffer = currentDirectory.appendingPathComponent("\(name).txt")

    ignite()
  }

  func ignite() {
    while true {
      for (_, window) in windows {
        window.ignite()
      }
      gatherTouchInfo()
    }
  }

  func gatherTouchInfo() {
    do {
        guard let buffa = self.pointerBuffer else {
          return
        }
        let pointerInfo = try String(contentsOf: buffa, encoding: String.Encoding.utf8)
        let pointerCoords = pointerInfo.components(separatedBy: ",")
        if pointerCoords.count > 0 {
          for (_, window) in self.windows {
            window.touched(point: Point(x: Int(pointerCoords[0]) ?? 0, y: Int(pointerCoords[1]) ?? 0))
          }
        }
    }
    catch {
      for (_, window) in windows {
        window.touchLifted()
      }
    }
  }

}
