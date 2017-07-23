//
//  Logger+Shared.swift
//  Logger
//
//  Created by Sinoru on 2017. 7. 23..
//

extension Logger {
    public static let shared: Logger = {
        return Logger()
    }()

    public static func debug(_ format: StaticString, _ args: CVarArg...) {
        Logger.shared.log(level: .debug, format: format, args)
    }

    public static func info(_ format: StaticString, _ args: CVarArg...) {
        Logger.shared.log(level: .info, format: format, args)
    }

    public static func warn(_ format: StaticString, _ args: CVarArg...) {
        Logger.shared.log(level: .warning, format: format, args)
    }

    public static func error(_ format: StaticString, _ args: CVarArg...) {
        Logger.shared.log(level: .error, format: format, args)
    }

    public static func fault(_ format: StaticString, _ args: CVarArg...) {
        Logger.shared.log(level: .fault, format: format, args)
    }
}
