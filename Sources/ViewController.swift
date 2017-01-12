// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class ViewController {

  var view: View?

  // touchdown
  var lastTouch: Point!
  var manualTouchOverride = false

  var buttons = [Button]()

  init(view: View) {
    self.view = view
  }

  func ignite() -> Image? {
    return view?.ignite()
  }

}

extension ViewController {

  // override these to provide manual behavior

  func touchBegan(point: Point) {
    print("touch began")
    self.lastTouch = Point(x: point.x, y: point.y)
    //self.view?.backgroundColor = Color.green
    self.view?.clickDown(point: point)
  }

  func touchMoved(point: Point) {
    //guard let view = self.view else {
    //  return
    //}
    //view.frame.x = view.frame.x + (point.x - lastTouch.x)
    //view.frame.y = view.frame.y + (point.y - lastTouch.y)
    self.lastTouch = Point(x: point.x, y: point.y)
    self.view?.backgroundColor = Color.red
  }

  func touchEnded(point: Point) {
    self.view?.backgroundColor = Color.blue
  }

  func thisIsMyTouch(point: Point) -> Bool {
    return self.manualTouchOverride
  }

}
