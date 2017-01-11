// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import swiftgd

class Application {

  var windows = [String: Window]()

  let windowSize = CGSize(width: 400, height: 400)

  let initialController = InitialViewController()

  func init(name: String) {
    let window = Window(identity: name, size: windowSize)
    windows.append(window)
    window.ignite()
  }

}
