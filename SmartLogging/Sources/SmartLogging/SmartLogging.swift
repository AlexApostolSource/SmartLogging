// The Swift Programming Language
// https://docs.swift.org/swift-book

import OSLog
import Foundation

public protocol SmartLoggingProtocol {
    func log(_ metadata: LogMetadata)
    func config(config: SmartLoggingConfigProtocol)
    func setGlobalLogLevel(_ level: LogLevel)
}

public protocol SmartLoggingConfigProtocol {
    var subsystem: Subsystem { get set }
}

public final class SmartLogging: SmartLoggingProtocol {
    static let shared = SmartLogging()
    private let lock: NSRecursiveLock = NSRecursiveLock()
    private var _currentLogLevel: LogLevel = .default
    private var _logger: SmartLogger
    private var logger: SmartLogger {
        get {
            lock.lock()
            defer { lock.unlock() }
            return _logger
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            _logger = newValue
        }
    }
    public var logLevel: LogLevel {
        return currentLogLevel
    }
    private var currentLogLevel: LogLevel {
        get {
            lock.lock()
            defer { lock.unlock() }
            return _currentLogLevel
        }
        set {
            lock.lock()
            defer { lock.unlock() }
            _currentLogLevel = newValue
        }
    }

    private init(logger: SmartLogger = Logger()) {
        self._logger = logger
    }

    /// Updates the logger instance in a thread-safe manner.
    /// If a log is sent while the logger is being updated, the log will be handled by whichever logger instance is active when the lock is acquired.
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


