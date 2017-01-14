// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class InitialViewController: ViewController {

  var tappyButton: Button?
  var stringyLabel: Label?

  init() {
    super.init(view: View(x: 0, y: 0, width: 300, height: 300))
    guard let _ = self.view else {
      return
    }
    // run some default code here
    self.createCalculatorKeypad(defaultPath: "UI/calc.jpg", downPath: "UI/calc.jpg", frame: nCGRect(x: 50, y: 100, width: 200, height: 200))

    // create some label
    let label = Label(backgroundColor: Color.white, fontColor: Color.black, fontSize: FontSize.large, frame: nCGRect(x: 20, y: 20, width: 100, height: 50))
    label.setText(text: "TuneIn")
    self.view?.addSubview(view: label)
    self.stringyLabel = label

  }

  func createCalculatorKeypad(defaultPath: String, downPath: String, frame: nCGRect) {
    let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
    let buttonDefaultFile = currentDirectory.appendingPathComponent(defaultPath)
    let buttonDownFile = currentDirectory.appendingPathComponent(downPath)
    do {
      guard let buttonDefaultImage = Image(url: buttonDefaultFile) else {
        return
      }
      guard let buttonDownImage = Image(url: buttonDownFile) else {
        return
      }
      let butt = Button(frame: frame, defaultImage: buttonDefaultImage, touchdownImage: buttonDownImage)
      self.view?.addSubview(view: butt)
      self.tappyButton = butt

      butt.clickDownActions = [{ (point: Point, button: Button?) -> Void in
        let rando = Int(random())
        self.stringyLabel?.setText(text: "\(rando)")
      }]
    } catch {
      print("fokken hell")
    }
  }

}
