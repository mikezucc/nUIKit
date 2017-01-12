// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class Button: View {

  var image: Image?

  init(frame: nCGRect, image: Image?) {
    super.init(x: frame.x, y: frame.y, width: frame.width, height: frame.height)

    self.image = image?.resizedTo(width: self.frame.width, height: self.frame.height)
  }

  override func ignite() -> Image? {
    guard let _ = self.image else {
      return nil
    }
    print("attempting to render button")
    let resizedImage = self.image?.resizedTo(width: self.frame.width, height: self.frame.height)
    return resizedImage
  }

  func clickDown() {

  }

}
