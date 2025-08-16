//
//  Test.swift
//  SmartLogging
//
//  Created by Alex.personal on 16/8/25.
//

@testable import SmartLogging
import OSLog
import Testing

@Suite("LogLevel")
struct LogLevelTests {
    @Test("raw values are correct")
    func testRawValues() {
        #expect(LogLevel.default.rawValue == 0)
        #expect(LogLevel.debug.rawValue == 1)
        #expect(LogLevel.info.rawValue == 2)
        #expect(LogLevel.warning.rawValue == 3)
        #expect(LogLevel.error.rawValue == 4)
        #expect(LogLevel.fault.rawValue == 5)
    }

    @Test("comparability works")
    func testComparability() {
        #expect(LogLevel.debug > .default)
        #expect(LogLevel.info > .debug)
        #expect(LogLevel.warning > .info)
        #expect(LogLevel.error > .warning)
        #expect(LogLevel.fault > .error)
        #expect(!(LogLevel.default > .fault))
    }

    @Test("asOSLogLevel mapping")
    func testAsOSLogLevel() {
        #expect(LogLevel.default.asOSLogLevel == .default)
        #expect(LogLevel.debug.asOSLogLevel == .debug)
        #expect(LogLevel.info.asOSLogLevel == .info)
        #expect(LogLevel.warning.asOSLogLevel == .info)
        #expect(LogLevel.error.asOSLogLevel == .error)
        #expect(LogLevel.fault.asOSLogLevel == .fault)
    }
}

@Suite("ConsoleLogging")
struct ConsoleLoggingTests {
    @Test("enum cases exist")
    func testCases() {
        #expect(ConsoleLogging.active != ConsoleLogging.inactive)
    }
}
