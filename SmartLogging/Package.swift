// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SmartLogging",
    platforms: [.iOS(.v15), .macOS(.v14)],
    products: [
        .library(
            name: "SmartLogging",
            targets: ["SmartLogging"]
        ),
    ],
    targets: [
        .target(
            name: "SmartLogging"
        ),
        .testTarget(
            name: "SmartLoggingTests",
            dependencies: ["SmartLogging"]
        ),
    ]
)
