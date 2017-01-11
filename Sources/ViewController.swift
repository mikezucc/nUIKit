// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import swiftgd

class ViewController {

  var view: View?

  init(view: View) {
    self.view = view
  }

  func ignite() -> Image? {
    return view?.ignite()
  }

}
