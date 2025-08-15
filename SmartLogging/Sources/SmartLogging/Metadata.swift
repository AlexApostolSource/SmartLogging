//
//  Metadata.swift
//  SmartLogging
//
//  Created by Alex.personal on 15/8/25.
//

import Foundation

public struct LogMetadata {
    public let logLevel: LogLevel
    public let properties: [String: Any]
    public let message: String
    public let consoleLogging: ConsoleLogging
    public let messageStart: String
    public let propertiesStart: String
    public let logger: SmartLogger?

    public init(
        logLevel: LogLevel,
        properties: [String: Any],
        message: String,
        consoleLogging: ConsoleLogging,
        messageStart: String = "Message",
        propertiesStart: String = "properties",
        logger: SmartLogger? = nil
    ) {
        self.logLevel = logLevel
        self.properties = properties
        self.message = message
        self.consoleLogging = consoleLogging
        self.messageStart = messageStart
        self.propertiesStart = propertiesStart
        self.logger = logger
    }
}
