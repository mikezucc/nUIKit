// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class InitialViewController: ViewController {

  var tappyButton: Button?

  init() {
    super.init(view: View(x: 0, y: 0, width: 500, height: 500))
    guard let view = self.view else {
      return
    }
    // run some default code here
    self.createUI(path: "UI/tab.jpg", frame:  nCGRect(x: 0, y: view.frame.height-50, width: view.frame.width, height: 50))
    self.createUI(path: "UI/home.jpg", frame:  nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
    //self.createUI(path: "UI/profile.jpg", frame:  nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
    //self.createUI(path: "UI/browse.jpg", frame:  nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
    //self.createUI(path: "UI/search.jpg", frame: nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
    //self.createUI(path: "UI/record.jpg", frame:  nCGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height-50))
  }

  func createUI(path: String, frame: nCGRect) {
    let currentDirectory = URL(fileURLWithPath: FileManager().currentDirectoryPath)
    let buttonFile = currentDirectory.appendingPathComponent(path)
    do {
      guard let buttonImage = Image(url: buttonFile) else {
        return
      }
      let butt = Button(frame: frame, image: buttonImage)
      self.view?.addSubview(view: butt)
      self.tappyButton = butt
    } catch {
      print("fokken hell")
    }
  }

}
