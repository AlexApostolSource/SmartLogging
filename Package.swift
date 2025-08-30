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
        // --- SwiftLint Plugin ---
        // Disabled for PRODUCTION builds (avoid forcing consumers to run SwiftLint).
        // Enable this block only for DEVELOPMENT if you want linting during builds.
        /*
         .plugin(
         name: "SmartLoggingSwiftLintBuildToolPlugin",
         capability: .buildTool(),
         path: "Plugins/SmartLoggingSwiftLintBuildToolPlugin"
         ),
         */

        .target(
            name: "SmartLogging"
            // , plugins: [
            //     // SwiftLint plugin attached to this target.
            //     // Disabled for PRODUCTION — enable in DEVELOPMENT only.
            //     .plugin(name: "SmartLoggingSwiftLintBuildToolPlugin")
            // ]
        ),
        .testTarget(
            name: "SmartLoggingTests",
            dependencies: ["SmartLogging"]
            // , plugins: [
            //     // SwiftLint plugin attached to tests.
            //     // Disabled for PRODUCTION — enable in DEVELOPMENT only.
            //     .plugin(name: "SmartLoggingSwiftLintBuildToolPlugin")
            // ]
        )
    ]
)

