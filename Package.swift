// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "MySwiftPackage",
    dependencies: [
        .package(url: "https://github.com/yume190/CodeView", from: "0.0.1"),
    ])