// The Swift Programming Language
// https://docs.swift.org/swift-book

import OSLog
import Foundation

public protocol SmartLoggingProtocol: Sendable {
    func logDebug(_ metadata: LogMetadata) async
    func logDefault(_ metadata: LogMetadata) async
    func logInfo(_ metadata: LogMetadata) async
    func logWarning(_ metadata: LogMetadata) async
    func logError(_ metadata: LogMetadata) async
    func logFault(_ metadata: LogMetadata) async
    func log(_ metadata: SmartLogMetadata) async
}

public protocol SmartConfigLoggingProtocol: Sendable, SmartLoggingProtocol {
    /// Updates the logger instance in a thread-safe manner.
    /// If a log is sent while the logger is being updated, the log will be handled by whichever
    /// logger instance is active when the lock is acquired.
    /// No logs will be lost or corrupted, but the specific logger used for concurrent operations cannot be guaranteed.
    func config(config: SmartLogging) async
    func setGlobalLogLevel(_ level: LogLevel) async
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
    public func config(config: SmartLogger) {
        logger = config
    }

    public func setGlobalLogLevel(_ level: LogLevel) {
        currentLogLevel = level
    }

    public func log(_ metadata: SmartLogMetadata) async {
        if metadata.logLevel >= currentLogLevel {
            logger.log(metadata)
        }
    }

    public func logDebug(_ metadata: LogMetadata) async {
        await log(SmartLogMetadata(logLevel: .debug, logMetadata: metadata, logger: logger))
    }

    public func logDefault(_ metadata: LogMetadata) async {
        await log(SmartLogMetadata(logLevel: .default, logMetadata: metadata, logger: logger))
    }

    public func logInfo(_ metadata: LogMetadata) async {
        await log(SmartLogMetadata(logLevel: .info, logMetadata: metadata, logger: logger))
    }

    public func logWarning(_ metadata: LogMetadata) async {
        await log(SmartLogMetadata(logLevel: .warning, logMetadata: metadata, logger: logger))
    }

    public func logError(_ metadata: LogMetadata) async {
        await log(SmartLogMetadata(logLevel: .error, logMetadata: metadata, logger: logger))
    }

    public func logFault(_ metadata: LogMetadata) async {
        await log(SmartLogMetadata(logLevel: .fault, logMetadata: metadata, logger: logger))
    }
}
