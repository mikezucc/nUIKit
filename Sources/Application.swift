// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import swiftgd

class Application {

  var windows = [String: Window]()

  let windowSize = nCGRect(x:0, y:0, width: 400, height: 400)

  init?(name: String) {
    let window = Window(identity: name, rect: windowSize)
    windows = [name: window]
    window.ignite()
  }

}
