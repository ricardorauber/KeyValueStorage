// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "KeyValueStorage",
    platforms: [
        .iOS(.v12), .macOS(.v10_14), .tvOS(.v12)
    ],
    products: [
        .library(name: "KeyValueStorage", targets: ["KeyValueStorage"]),
    ],
    targets: [
        .target(name: "KeyValueStorage", path: "Classes"),
    ]
)
