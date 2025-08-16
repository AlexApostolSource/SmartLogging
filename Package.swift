// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SmartLogging",
    platforms: [.iOS(.v15), .macOS(.v14)],
    products: [
        .library(
            name: "SmartLogging",
            targets: ["SmartLogging"]
        )
    ],
    targets: [
        .plugin(
            name: "SmartLoggingSwiftLintBuildToolPlugin",
            capability: .buildTool(),
            path: "Plugins/SmartLoggingSwiftLintBuildToolPlugin"
        ),
        .target(
            name: "SmartLogging", plugins: [
                .plugin(name: "SmartLoggingSwiftLintBuildToolPlugin")
            ]
        ),
        .testTarget(
            name: "SmartLoggingTests", dependencies: ["SmartLogging"], plugins: [
                .plugin(name: "SmartLoggingSwiftLintBuildToolPlugin")
            ]
        )
    ]
)
