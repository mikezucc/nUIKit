import PackageDescription

let package = Package(
    name: "nUIKit",
    targets: [
                 Target(name: "nUIKit")
    ],
    dependencies: [
        .Package(url: "https://github.com/mikezucc/SwiftGD", majorVersion: 1, minor: 2)
    ],
    exclude: ["Xcode"]
)
