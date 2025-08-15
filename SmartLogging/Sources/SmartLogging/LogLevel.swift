//
//  Logger.swift
//  SmartLogging
//
//  Created by Alex.personal on 3/8/25.
//
import OSLog

public enum LogLevel: Int, Comparable {
    case `default` = 0
    case debug
    case info
    case warning
    case error
    case fault

    public static func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

public enum ConsoleLogging {
    case active
    case inactive
}

public extension LogLevel {
    var asOSLogLevel: OSLogType {
        switch self {
        case .debug:
            return .debug
        case .info:
            return .info
        case .error:
            return .error
        case .default:
            return .default
        case .fault:
            return .fault
        case .warning:
            return .info // OSLogType does not have a direct warning level, using fault as a fallback
        }
    }
}
