// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

class InitialViewController: ViewController {

  let childViewController = ViewController(view: View(x: 10, y: 10, width: 100, height: 100))

  init() {
    super.init(view: View(x: 20, y: 20, width: 100, height: 100))
    // run some default code here
    childViewController.view?.currIdx = 10
    childViewController.view?.idxColors = 2
    self.view?.addSubview(view: childViewController.view!)
  }

}
