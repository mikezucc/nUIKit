// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class Application {

  let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
  var pointerBuffer: URL?

  var windows = [String: Window]()

  let windowSize = nCGRect(x:0, y:0, width: 300, height: 300)

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
      // pause for 100ms
      usleep(1000 * 100)
    }
  }

  func gatherTouchInfo() {
    do {
        guard let buffa = self.pointerBuffer else {
          print("**ERROR: failed to create pointer buffer")
          return
        }
        let pointerInfo = try String(contentsOf: buffa, encoding: String.Encoding.utf8)
        print("\n\t Pointer Info: \(pointerInfo)")
        let pointerCoords = pointerInfo.components(separatedBy: ",")
        print("\n\t\(pointerCoords)")
        if pointerCoords.count > 0 {
          for (_, window) in self.windows {
            window.touched(point: Point(x: Int(pointerCoords[0]) ?? 0, y: Int(pointerCoords[1]) ?? 0))
          }
        }
    }
    catch {
      print("\n\t **ERROR: failed to get pointer buffer")
      for (_, window) in windows {
        window.touchLifted()
      }
    }
  }

}
