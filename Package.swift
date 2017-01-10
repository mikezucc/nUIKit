import PackageDescription

let package = Package(
    name: "nUIKit",
    targets: [
                 Target(name: "nUIKit")
    ],
    dependencies: [
        .Package(url: "https://github.com/twostraws/SwiftGD.git", majorVersion: 1, minor: 0)
    ],
    exclude: ["Xcode"]
)

