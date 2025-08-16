import XCTest
@testable import SmartLogging

final class SmartLoggingTests: XCTestCase {
    final class MockLogger: SmartLogger {
        var logged: [SmartLogMetadata] = []
        let logQueue = DispatchQueue(label: "mock.logger")
        required init(subsystem: String, category: String) {}
        required init() {}
        func log(_ metadata: SmartLogMetadata) {
            logged.append(metadata)
        }
    }

    func makeLogMetadata(message: String = "msg", properties: [String: Any] = [:]) -> LogMetadata {
        LogMetadata(properties: properties, message: message)
    }

    func testLogFiltersByLogLevel() async {
        let logger = MockLogger()
        let smartLogging = SmartLogging.shared
        await SmartLogging.shared.config(config: logger)
        await smartLogging.setGlobalLogLevel(.info)
        await smartLogging.log(SmartLogMetadata(logLevel: .debug, logMetadata: makeLogMetadata(), logger: logger))
        await smartLogging.log(SmartLogMetadata(logLevel: .info, logMetadata: makeLogMetadata(), logger: logger))
        await smartLogging.log(SmartLogMetadata(logLevel: .error, logMetadata: makeLogMetadata(), logger: logger))
        XCTAssertEqual(logger.logged.count, 2)
        XCTAssertTrue(logger.logged.allSatisfy { $0.logLevel >= .info })
    }

    func testLogDebug() async {
        let logger = MockLogger()
        let smartLogging = SmartLogging.shared
        await SmartLogging.shared.config(config: logger)
        await smartLogging.setGlobalLogLevel(.debug)
        let meta = makeLogMetadata(message: "debug")
        await smartLogging.logDebug(meta)
        XCTAssertEqual(logger.logged.count, 1)
        XCTAssertEqual(logger.logged.first?.logLevel, .debug)
        XCTAssertEqual(logger.logged.first?.logMetadata.message, "debug")
    }

    func testLogError() async {
        let logger = MockLogger()
        let smartLogging = SmartLogging.shared
        await SmartLogging.shared.config(config: logger)
        await smartLogging.setGlobalLogLevel(.default)
        let meta = makeLogMetadata(message: "error")
        await smartLogging.logError(meta)
        XCTAssertEqual(logger.logged.count, 1)
        XCTAssertEqual(logger.logged.first?.logLevel, .error)
        XCTAssertEqual(logger.logged.first?.logMetadata.message, "error")
    }

    func testSetGlobalLogLevel() async {
        let logger = MockLogger()
        let smartLogging = SmartLogging.shared
        await SmartLogging.shared.config(config: logger)
        await smartLogging.setGlobalLogLevel(.fault)
        let logLevel = await smartLogging.logLevel
        XCTAssertEqual(logLevel, .fault)
    }
}
