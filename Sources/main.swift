// run export PATH=~/swift3/usr/bin/:"${PATH}" in pwd first
import Foundation
import Glibc
import Dispatch
import SwiftGD

let app = Application(name: "Hackweek")

while let apply = app {
  print("running \(apply.windows)")
  usleep(1000 * 300)
}
