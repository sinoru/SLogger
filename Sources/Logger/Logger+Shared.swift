//
//  Logger+Shared.swift
//  Logger
//
//  Created by Sinoru on 2017. 7. 23..
//  Copyright © 2017 Sinoru. All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.

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
