//
//  SmartLogger.swift
//  SmartLogging
//
//  Created by Alex.personal on 15/8/25.
//
import OSLog

import Foundation

public protocol SmartLogger {
    func log(_ metadata: LogMetadata)
    init(subsystem: String, category: String)
    init()
    var logQueue: DispatchQueue { get }
}

extension Logger: SmartLogger {
    private static let logQueue = DispatchQueue(label: "com.smartLogging.logger")
    public var logQueue: DispatchQueue {
        Logger.logQueue
    }

    public func log(_ metadata: LogMetadata) {
        logQueue.async {
            log(
                level: metadata.logLevel.asOSLogLevel,
                "\(metadata.messageStart): \(metadata.message) \(metadata.propertiesStart): \(metadata.properties)"
            )
        }
    }
}
