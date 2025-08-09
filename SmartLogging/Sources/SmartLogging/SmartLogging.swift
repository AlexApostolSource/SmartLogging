// The Swift Programming Language
// https://docs.swift.org/swift-book

import OSLog
import Foundation

public struct LogMetadata {
    private let logLevel: LogLevel
    private let properties: [String: Any]
    private let message: String
    private let consoleLogging: ConsoleLogging
}

public protocol SmartLoggingProtocol {

}

public final class SmartLogging {
    static let shared = SmartLogging()
    private let logger = Logger()

    private init() {}
}
