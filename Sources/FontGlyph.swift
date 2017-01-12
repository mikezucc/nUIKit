// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class Glyph: View {

  // use this when you want to treat the View as an Image with a **frame** property
  // see FontLarge for usage as glyph
  var glyph: Image?

  init(glyph: Image, frame: nCGRect) {
    super.init()
    self.glyphOverride = glyph
    self.frame = frame
  }

  override func ignite() -> Image? {
    return self.glyph
  }

}
