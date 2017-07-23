//
//  Logger.swift
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
import LogDestinations

open class Logger {
    public static let shared: Logger = {
        return Logger()
    }()

    public let identifier: String?
    public let category: String?
    
    private let mainQueue: DispatchQueue
    
    private let destinations: [LoggerDestination]

    public init(identifier: String? = nil, category: String? = nil, destinationTypes: [LoggerDestination.Type] = [SystemDestination.self]) {
        self.identifier = identifier
        self.category = category
        
        self.mainQueue = DispatchQueue(label: "com.sinoru.Logger", qos: .default, attributes: .concurrent, target: nil)
        
        var destinations = [LoggerDestination]()
        for destinationType in destinationTypes {
            destinations.append(destinationType.init(identifier: identifier, category: category))
        }
        self.destinations = destinations
    }
    
    func log(level: LogLevel, format: StaticString, _ args: CVarArg...) {
        self.destinations.map({ destination in
            return DispatchWorkItem(block: {
                destination.log(level: level, format: format, args)
            })
        }).forEach({self.mainQueue.async(execute: $0)})
    }

    func debug(_ format: StaticString,_ args: CVarArg...) {
        self.log(level: .debug, format: format, args)
    }

    func info(_ format: StaticString,_ args: CVarArg...) {
        self.log(level: .info, format: format, args)
    }
}
