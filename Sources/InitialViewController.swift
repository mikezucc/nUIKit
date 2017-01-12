// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class InitialViewController: ViewController {

  var tappyButton: Button?
  var stringyLabel: Label?

  init() {
    super.init(view: View(x: 0, y: 0, width: 800, height: 600))
    guard let _ = self.view else {
      return
    }
    // run some default code here
    self.createButton(defaultPath: "UI/normal.png", downPath: "UI/highlighted.png", frame: nCGRect(x: 50, y: 50, width: 150, height: 50))

    // create some label
    let label = Label(backgroundColor: Color.white, fontColor: Color.black, fontSize: FontSize.large, frame: nCGRect(x: 20, y: 200, width: 100, height: 200))
    label.setText(text: "Memes")
    self.view?.addSubview(view: label)
    self.tappyLabel = label

    //self.createUI(path: "UI/tab.jpg", frame:  nCGRect(x: 0, y: view.frame.height-50, width: view.frame.width, height: 50))
    //self.createUI(path: "UI/home.jpg", frame:  nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
    //self.createUI(path: "UI/profile.jpg", frame:  nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
    //self.createUI(path: "UI/browse.jpg", frame:  nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
    //self.createUI(path: "UI/search.jpg", frame: nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
    //self.createUI(path: "UI/record.jpg", frame:  nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
  }

  func createButton(defaultPath: String, downPath: String, frame: nCGRect) {
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
        print("\n\n\n\n\n\n\n\nCLICKED THIS LOL\n\n\n\n\n\n\n\n\n")
      }]
    } catch {
      print("fokken hell")
    }
  }

}
