// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import swiftgd

struct nCGRect {
  var x: Double = 0
  var y: Double = 0
  var width: Double = 0
  var height: Double = 0
}

class View {

  // top most view is in the back
  var subviews = [View]()

  var frame = nCGRect()
  var backgroundColor = Color.white()

  func init(x: Double, y: Double, width: Double, height: Double) {
    frame.x = x
    frame.y = y
    frame.width = width
    frame.height = height
  }

  func addSubview(view: View) {
    subviews.append(view)
  }

  // subclasses of view
  func ignite() -> Image {
    let masterImage = Image(width: frame.width, height: frame.height)
    masterImage.fill(from: Point(x: 0, y: 0), color: self.backgroundColor)
    for view in subviews {
      let renderedSubview = view.ignite()
      let usableBoundWidth = frame.width - view.frame.x
      let usableBoundHeight = frame.height - view.frame.y
      for x in 0...usableBoundWidth {
        for y in 0...usableBoundHeight {
          let pixelColor = renderedSubview.get(pixel: Point(x: x, y: y))
          masterImage.set(pixel: Point(x: x + view.frame.x, y: y + view.frame.y), to: pixelColor)
        }
      }
    }
    return masterImage
  }

}
