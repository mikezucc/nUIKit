// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class FontLarge {
  // step in sprite
  static let fontStep = 128

  static let fontWidth = 8
  static let fontHeight = 16

  // lare font cache
  static let font = FontLarge()

  var cache = [String: Image]()

  init() {
    self.cache = FontLarge.generateFontCache()
  }

  class func generateFontCache() -> [String: Image] {
    print("\tGenerating font cache")
    print("\tCache Check \(FontLarge.fontSprite()[0...10]) with length \(FontLarge.fontSprite().count)")
    var scopedFontCache = [String: Image]()
    let sprite = FontLarge.fontSprite()
    print("\tLocal font check \(scopedFontCache)")
    for (chara, index) in fontSpriteIndex {
      print("\t Character \(chara) with \(index)")
      let fontSpriteSlice = sprite[index...(index + 128)]
      if let image = Image(width: FontLarge.fontWidth, height: FontLarge.fontHeight) {
        image.fill(from: Point(x: 0, y: 0), color: Color.white)
        var idx = 0
        for pix in fontSpriteSlice {
          print("\tWriting for \(idx) with \(pix)")
          if pix {
            image.set(pixel: Point(x: (idx % FontLarge.fontWidth), y: Int(idx / FontLarge.fontHeight) ), to: Color.green)
          }
          idx = idx + 1
        }
        scopedFontCache[chara] = image
      }
    }
    return scopedFontCache
  }

  static let fontSpriteIndex: [String: Int] = [
    "A": 65 * 128,
    "B": 66 * 128,
    "C": 67 * 128,
    "D": 68 * 128,
    "E": 69 * 128,
    "F": 70 * 128,
    "G": 71 * 128,
    "H": 72 * 128,
    "I": 73 * 128,
    "J": 74 * 128,
    "K": 75 * 128,
    "L": 76 * 128,
    "M": 77 * 128,
    "N": 78 * 128,
    "O": 79 * 128,
    "P": 80 * 128,
    "Q": 81 * 128,
    "R": 82 * 128,
    "S": 83 * 128,
    "T": 84 * 128,
    "U": 85 * 128,
    "V": 86 * 128,
    "W": 87 * 128,
    "X": 88 * 128,
    "Y": 89 * 128,
    "Z": 90 * 128,
    "a": 97 * 128,
    "b": 98 * 128,
    "c": 99 * 128,
    "d": 100 * 128,
    "e": 101 * 128,
    "f": 102 * 128,
    "g": 103 * 128,
    "h": 104 * 128,
    "i": 105 * 128,
    "j": 106 * 128,
    "k": 107 * 128,
    "l": 108 * 128,
    "m": 109 * 128,
    "n": 110 * 128,
    "o": 111 * 128,
    "p": 112 * 128,
    "q": 113 * 128,
    "r": 114 * 128,
    "s": 115 * 128,
    "t": 116 * 128,
    "u": 117 * 128,
    "v": 118 * 128,
    "w": 119 * 128,
    "x": 120 * 128,
    "y": 121 * 128,
    "z": 122 * 128,
  ]

  class func fontSprite() -> [Bool] {
    let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
    let spriteBuffa = currentDirectory.appendingPathComponent("utf8.txt")
    do {
      let pointerInfo = try String(contentsOf: spriteBuffa, encoding: String.Encoding.utf8)
      return pointerInfo.components(separatedBy: ",").flatMap({ $0.contains("1") })
    } catch {
      print("\tFailed to open the utf8 sprite file")
    }
    return []
  }

}
