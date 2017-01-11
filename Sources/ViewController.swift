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

  init(view: View) {
    self.view = view
  }

  func ignite() -> Image? {
    return view?.ignite()
  }

}

extension ViewController {

  func touchBegan(point: Point) {
    guard let view = self.view else {
      return
    }
    view.frame.x = view.frame.x - 20
    view.frame.y = view.frame.y - 20
    view.frame.width = view.frame.width + 40
    view.frame.height = view.frame.height + 40
    self.lastTouch = Point(x: point.x, y: point.y)
    self.view?.backgroundColor = Color.green
  }

  func touchMoved(point: Point) {
    guard let view = self.view else {
      return
    }
    view.frame.x = view.frame.x + (lastTouch.x - point.x)
    view.frame.y = view.frame.y + (lastTouch.y - point.y)
    self.lastTouch = Point(x: point.x, y: point.y)
    self.view?.backgroundColor = Color.black
  }

  func touchEnded(point: Point) {
    self.view?.backgroundColor = Color.blue
  }

  func thisIsMyTouch(point: Point) -> Bool {
    return self.manualTouchOverride
  }

}
