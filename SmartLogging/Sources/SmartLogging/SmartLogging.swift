// The Swift Programming Language
// https://docs.swift.org/swift-book

import OSLog
import Foundation

public protocol SmartLoggingProtocol: Sendable {
    func log(_ metadata: LogMetadata) async
    /// Updates the logger instance in a thread-safe manner.
    /// If a log is sent while the logger is being updated, the log will be handled by whichever
    /// logger instance is active when the lock is acquired.
    /// No logs will be lost or corrupted, but the specific logger used for concurrent operations cannot be guaranteed.
    func config(config: SmartLoggingConfigProtocol) async
    func setGlobalLogLevel(_ level: LogLevel) async
}

public protocol SmartLoggingConfigProtocol: Sendable {
    var subsystem: Subsystem { get set }
}

public final actor SmartLogging: SmartLoggingProtocol {
    public static let shared = SmartLogging()
    private var logger: SmartLogger
    public var logLevel: LogLevel {
        return currentLogLevel
    }
    private var currentLogLevel: LogLevel = .default

    private init(logger: SmartLogger = Logger()) {
        self.logger = logger
    }

    /// Updates the logger instance in a thread-safe manner.
    /// If a log is sent while the logger is being updated, the log will be handled by whichever
    /// logger instance is active when the lock is acquired.
    /// No logs will be lost or corrupted, but the specific logger used for concurrent operations cannot be guaranteed.
    public func config(config: SmartLoggingConfigProtocol) {
        logger = Logger(subsystem: config.subsystem.name, category: config.subsystem.category.name)
    }

    public func setGlobalLogLevel(_ level: LogLevel) {
        currentLogLevel = level
    }

    public func log(_ metadata: LogMetadata) {
        if metadata.logLevel >= currentLogLevel {
            if let logger = metadata.logger {
                logger.log(metadata)
            } else {
                logger.log(metadata)
            }
        }
    }
}
