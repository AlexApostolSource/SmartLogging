//
//  Test.swift
//  SmartLogging
//
//  Created by Alex.personal on 16/8/25.
//

import Foundation
@testable import SmartLogging
import Testing

final class MockLogger: SmartLogger {
    var loggedMetadata: [SmartLogMetadata] = []
    let logQueue = DispatchQueue(label: "mock.logger")
    init(subsystem: String, category: String) {}
    init() {}
    func log(_ metadata: SmartLogMetadata) {
        loggedMetadata.append(metadata)
    }
}

@Suite("SmartLogger")
struct SmartLoggerTests {
    @Test("log appends metadata")
    func testLogAppendsMetadata() {
        let logger = MockLogger()
        let metadata = SmartLogMetadata(
            logLevel: .debug,
            logMetadata: LogMetadata(properties: ["k": "v"], message: "Debug log")
        )
        logger.log(metadata)
        #expect(logger.loggedMetadata.count == 1)
        #expect(logger.loggedMetadata.first?.logLevel == .debug)
        #expect(logger.loggedMetadata.first?.logMetadata.message == "Debug log")
    }

    @Test("init with subsystem and category")
    func testInitWithSubsystemAndCategory() {
        let logger = MockLogger(subsystem: "test.subsystem", category: "test.category")
        #expect(logger.logQueue.label == "mock.logger")
    }

    @Test("init default")
    func testInitDefault() {
        let logger = MockLogger()
        #expect(logger.logQueue.label == "mock.logger")
    }

    @Test("logQueue is accessible")
    func testLogQueueIsAccessible() {
        let logger = MockLogger()
        #expect(!logger.logQueue.label.isEmpty)
    }
}
