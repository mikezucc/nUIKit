// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

struct nCGRect {
  var x: Int = 0
  var y: Int = 0
  var width: Int = 0
  var height: Int = 0
}

class View {

  // top most view is in the back
  var subviews = [View]()

  var frame = nCGRect()
  var backgroundColor = Color.white

  let possibleColors = [Color.red, Color.green, Color.blue, Color.black, Color.white]
  var idxColors = 0
  var currIdx = 0

  init(x: Int, y: Int, width: Int, height: Int) {
    frame.x = x
    frame.y = y
    frame.width = width
    frame.height = height
  }

  func addSubview(view: View) {
    subviews.append(view)
  }

  // for fun
  //  self.backgroundColor = self.possibleColors[idxColors]
  //  self.idxColors = (self.idxColors + 1) % self.possibleColors.count
  //  self.currIdx = (self.currIdx + 10) % self.frame.width
  //  self.frame.x = self.currIdx

  // subclasses of view
  func ignite() -> Image? {
    if let masterImage = Image(width: frame.width, height: frame.height) {
      masterImage.fill(from: Point(x: 0, y: 0), color: self.backgroundColor)
      for view in subviews {
        if let renderedSubview = view.ignite() {
          let usableBoundWidth = frame.width - view.frame.x <= view.frame.width ? frame.width - view.frame.x : view.frame.width
          let usableBoundHeight = frame.height - view.frame.y <= view.frame.height ? frame.height - view.frame.y : view.frame.height
          for x in 0...usableBoundWidth {
            for y in 0...usableBoundHeight {
              let pixelColor = renderedSubview.get(pixel: Point(x: x, y: y))
              masterImage.set(pixel: Point(x: x + view.frame.x, y: y + view.frame.y), to: pixelColor)
            }
          }
        }
      }
      return masterImage
    }

    return nil
  }

  func clickDown(point: Point) {
    for view in subviews {
      if view.frame.x <= point.x && view.frame.y <= point.y && point.x  <= view.frame.width + view.frame.x && point.y <= view.frame.height + view.frame.y {
        view.clickDown(point: point)
      }
    }
  }

}
