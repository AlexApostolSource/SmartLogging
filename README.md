# SmartLogging

SmartLogging is a Swift Package Manager (SPM) library designed to provide advanced and customizable logging functionality for Swift projects.

## Features

- Lightweight and easy to integrate with any Swift project.
- Flexible, async-safe, and extensible logging system.
- Supports log levels (default, debug, info, warning, error, fault).
- Easily configure subsystem/category and global log level.
- Suitable for use in iOS, macOS, and other Swift-based environments.
- Licensed under the MIT License.

## Installation

Add SmartLogging to your project using Swift Package Manager:

1. In Xcode, go to **File > Add Packages...**
2. Enter the repository URL:  
   `https://github.com/AlexApostolSource/SmartLogging`
3. Select the version or branch you wish to use.

Or add it directly to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/AlexApostolSource/SmartLogging.git", from: "1.0.0")
```

## Usage

### Basic Usage

```swift
import SmartLogging

// Configure the global logger (optional, uses OSLog.Logger by default)
let logger: SmartLogger = Logger(subsystem: "com.example.app", category: "network")
await SmartLogging.shared.config(config: logger)

// Set the global log level (default is .default)
await SmartLogging.shared.setGlobalLogLevel(.debug)

// Create log metadata
let meta = LogMetadata(properties: ["endpoint": "/api/v1/data"], message: "Fetching remote data")

// Log at specific levels
await SmartLogging.shared.logDebug(meta)
await SmartLogging.shared.logInfo(meta)
await SmartLogging.shared.logWarning(meta)
await SmartLogging.shared.logError(meta)
await SmartLogging.shared.logFault(meta)
```

### Adding Custom Properties

```swift
let meta = LogMetadata(
    properties: ["userID": 123, "action": "login"],
    message: "User login requested"
)
await SmartLogging.shared.logInfo(meta)
```

### Setting Log Level

```swift
await SmartLogging.shared.setGlobalLogLevel(.info)
```

Only logs with a level of `.info` or higher will be output.

### Custom Logger

You can provide your own `SmartLogger` implementation if you want custom handling (e.g., for unit tests or file logging):

```swift
final class MyCustomLogger: SmartLogger {
    func log(_ metadata: SmartLogMetadata) {
        print("[\(metadata.logLevel)] \(metadata.logMetadata.message)")
    }
    required init(subsystem: String, category: String) {}
    required init() {}
    var logQueue: DispatchQueue = .main
}
await SmartLogging.shared.config(config: MyCustomLogger())
```

## Log Levels

- `.default`
- `.debug`
- `.info`
- `.warning`
- `.error`
- `.fault`

## Types

- `LogMetadata`: Attach arbitrary properties and a message.
- `SmartLogMetadata`: Used internally, wraps `LogMetadata` with level, logger, and console logging options.

## License

This project is licensed under the [MIT License](LICENSE).

---
Created by [AlexApostolSource](https://github.com/AlexApostolSource)
