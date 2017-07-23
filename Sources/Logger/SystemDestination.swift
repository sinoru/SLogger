//
//  SystemDestination.swift
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

import Foundation
import os.log
import asl

public class SystemDestination: LoggerDestination {

    private let osLog: OSLog!
    private let asl: asl_object_t!

    public let identifier: String?
    public let category: String?

    public required init(identifier: String? = nil, category: String? = nil) {
        self.identifier = identifier
        self.category = category

        if #available(OSX 10.12, *) {
            if let identifier = self.identifier, let category = self.category {
                self.osLog = OSLog(subsystem: identifier, category: category)
            } else {
                self.osLog = OSLog.default
            }
            self.asl = nil
        } else {
            self.osLog = nil
            self.asl = asl_open(self.category?.cString(using: .utf8), self.identifier?.cString(using: .utf8), UInt32(ASL_OPT_STDERR))
        }
    }

    public func log(level: LogLevel, format: StaticString, _ args: CVarArg...) {
        if #available(OSX 10.12, *) {
            var osLevel: OSLogType

            switch level {
            case .debug:
                osLevel = .debug
            case .info:
                osLevel = .info
            case .warning:
                osLevel = .default
            case .error:
                osLevel = .error
            case .fault:
                osLevel = .fault
            }

            os_log(format, log: self.osLog, type: osLevel, args)
        } else {
            var aslLevel: Int32

            switch level {
            case .debug:
                aslLevel = ASL_LEVEL_DEBUG
            case .info:
                aslLevel = ASL_LEVEL_INFO
            case .warning:
                aslLevel = ASL_LEVEL_WARNING
            case .error:
                aslLevel = ASL_LEVEL_ERR
            case .fault:
                aslLevel = ASL_LEVEL_CRIT
            }

            _ = withVaList(args) { CVarArgsPointer in
                format.utf8Start.withMemoryRebound(to: Int8.self, capacity: 1) {
                    asl_vlog(self.asl, nil, aslLevel, $0, CVarArgsPointer)
                }
            }
        }
    }

}
