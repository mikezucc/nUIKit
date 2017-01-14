// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

enum FontSize {
  case large
}

class Label: View {

  var internalText: String?
  var fontColor = Color.black
  var fontSize = FontSize.large

  init(backgroundColor: Color, fontColor: Color, fontSize: FontSize, frame: nCGRect) {
    super.init(x: frame.x, y: frame.y, width: frame.width, height: frame.height)

    self.backgroundColor = backgroundColor
    self.fontColor = fontColor
    self.fontSize = fontSize
    self.frame = frame
  }

  override func ignite() -> Image? {
    return super.ignite()?.resizedTo(width: frame.width * 2, height: frame.height * 2)
  }

  func setText(text: String) {
    if text == self.internalText {
      print("Using same label cache")
      return
    }
    self.internalText = text
    self.subviews = []
    var offset = 0
    for index in text.characters.indices {
      let char = String(text[index])
      print("\tRendering \(char)")
      if let image = Image(width: FontLarge.fontWidth, height: FontLarge.fontHeight) {
        image.fill(from: Point(x: 0, y: 0), color: Color.white)
        if let fontImage = FontLarge.font.cache[char] {
          print("\tUsing font image \(fontImage)")
          let glyph = Glyph(glyph: fontImage, frame: nCGRect(x: offset * FontLarge.fontWidth, y: 0, width: FontLarge.fontWidth, height: FontLarge.fontHeight))
          addSubview(view: glyph)
          offset = offset + 1
        } else {
          print("Failed to find glyph")
        }
      }
    }
  }

}
