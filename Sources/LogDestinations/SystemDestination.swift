//
//  SystemDestination.swift
//  Logger
//
//  Created by Sinoru on 2017. 3. 14..
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
            self.asl = asl_open(self.category?.cString(using: .utf8), self.identifier?.cString(using: .utf8), 0)
        }
    }

    public func log(level: LogLevel, format: StaticString, _ args: CVarArg...) {
        switch level {
        case .debug:
            if #available(OSX 10.12, *) {
                os_log(format, log: self.osLog, type: .debug, args)
            } else {
                _ = withVaList(args) { CVarArgsPointer in
                    format.utf8Start.withMemoryRebound(to: Int8.self, capacity: 1) {
                        asl_vlog(self.asl, nil, ASL_LEVEL_DEBUG, $0, CVarArgsPointer)
                    }
                }
            }
        case .info:
            if #available(OSX 10.12, *) {
                os_log(format, log: self.osLog, type: .debug, args)
            } else {
                _ = withVaList(args) { CVarArgsPointer in
                    format.utf8Start.withMemoryRebound(to: Int8.self, capacity: 1) {
                        asl_vlog(self.asl, nil, ASL_LEVEL_INFO, $0, CVarArgsPointer)
                    }
                }
            }
        case .error:
            if #available(OSX 10.12, *) {
                os_log(format, log: self.osLog, type: .error, args)
            } else {
                _ = withVaList(args) { CVarArgsPointer in
                    format.utf8Start.withMemoryRebound(to: Int8.self, capacity: 1) {
                        asl_vlog(self.asl, nil, ASL_LEVEL_ERR, $0, CVarArgsPointer)
                    }
                }
            }
        }
    }
}
