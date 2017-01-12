// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

enum ButtonStates {
  case Default
  case Down
}

class Button: View {

  var currentState = ButtonStates.Default
  var images: [ButtonStates: Image]?
  var image: Image?

  weak var parentView: View?

  // define click actions that can understand their context, i.e. multiple actions from one button
  var clickDownActions: [((Point, Button?)->Void)]?

  let touchDownAnimationDecayTime = 5 // 5 render loops
  var touchDownDecay = 0

  init(frame: nCGRect, defaultImage: Image, touchdownImage: Image?) {
    super.init(x: frame.x, y: frame.y, width: frame.width, height: frame.height)

    guard let resizedDefaultImage = defaultImage.resizedTo(width: self.frame.width, height: self.frame.height) else {
      print("Big fuckup here if you are reading this lol")
      return
    }
    let resizedTouchdownImage = touchdownImage?.resizedTo(width: self.frame.width, height: self.frame.height) ?? resizedDefaultImage
    self.images = [ButtonStates.Default: resizedDefaultImage, ButtonStates.Down: resizedTouchdownImage]
  }

  override func ignite() -> Image? {
    if self.touchDownDecay > 0 {
      self.touchDownDecay = self.touchDownDecay - 1
      self.currentState = ButtonStates.Down
    } else {
      self.currentState = ButtonStates.Default
    }
    print("attempting to render button")
    let resizedImage = self.images?[self.currentState]?.resizedTo(width: self.frame.width, height: self.frame.height)
    return resizedImage
  }

  // implement this to receive click event, and do more than one action per event
  override func clickDown(point: Point) {
    self.touchDownDecay = self.touchDownAnimationDecayTime
    weak var weakSelf = self
    let _ = self.clickDownActions?.map({ $0(point, weakSelf) })
  }

}
