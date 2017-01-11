// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import swiftgd

class ViewController {

  var view: View?

  func init(view: View) {
    self.view = view
  }

  func showMe() -> Image {
    return view.ignite()
  }

}
