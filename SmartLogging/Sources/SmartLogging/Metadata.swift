//
//  Metadata.swift
//  SmartLogging
//
//  Created by Alex.personal on 15/8/25.
//

import Foundation

public struct SmartLogMetadata {
    public let logLevel: LogLevel
    public let logMetadata: LogMetadata
    public let consoleLogging: ConsoleLogging
    public let logger: SmartLogger?

    public init(
        logLevel: LogLevel,
        logMetadata: LogMetadata,
        consoleLogging: ConsoleLogging = .active,
        logger: SmartLogger? = nil
    ) {
        self.logLevel = logLevel
        self.logMetadata = logMetadata
        self.consoleLogging = consoleLogging
        self.logger = logger
    }
}

public struct LogMetadata {
    public let properties: [String: Any]
    public let message: String
    public let logger: SmartLogger?

    public init(
        properties: [String: Any],
        message: String,
        logger: SmartLogger? = nil
    ) {
        self.properties = properties
        self.message = message
        self.logger = logger
    }
}
