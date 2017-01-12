// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class Label: View {

  var internalText: String?
  var fontColor = Color.black
  var fontSize = FontSize.mediumBold

  init(backgroundColor: Color, fontColor: Color, fontSize: FontSize, frame: nCGRect) {
    super.init(x: frame.x, y: frame.y, width: frame.width, height: frame.height)

    self.backgroundColor = backgroundColor
    self.fontColor = fontColor
    self.fontSize = fontSize
    self.frame = frame
  }

  override func ignite() -> Image? {
    guard let text = text else {
      return nil
    }
    return super.ignite()
  }

  func setText(text: String) {
    if text == self.internalText {
      print("Using same label cache")
      return
    }
    self.internalText = text
    self.subviews = []
    var offset = 0jjjjj
    for index in text.characters.indices {
      let char = text[index]
      let image = Image(width: FontLarge.fontWidth, height: FontLarge.fontHeight)
      image.fill(from: Point(x: 0, y: 0), color: Color.white)
      if let fontImage = FontLarge.font.cache[char] {
        let fontGlyph = FontGlyph(glyph: fontImage, frame: nCGRect(x: offset * FontLarge.fontWidth, y: 0))
        addSubview(view: fontGlyph)
      }
    }
  }

}
