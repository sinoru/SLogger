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

private let globalQueue = DispatchQueue(label: "com.sinoru.Logger", qos: .default, attributes: .concurrent, target: nil)

open class Logger {

    public static var globalDestinationTypes: [LoggerDestination.Type] = [] {
        didSet {
            globalQueue.async {
                self.loggers.values.flatMap { $0.weakObject }.forEach { logger in
                    logger.mainQueue.async {
                        logger.updateDestinations()
                    }
                }
            }
        }
    }

    private static var loggers: [ObjectIdentifier: Weak<Logger>] = [:]

    public let identifier: String?
    public let category: String?

    public var destinationTypes: [LoggerDestination.Type] {
        didSet {
            self.updateDestinations()
        }
    }

    internal let mainQueue: DispatchQueue
    internal var destinations: [ObjectIdentifier:LoggerDestination] = [:]

    public init(identifier: String? = nil, category: String? = nil, destinationTypes: [LoggerDestination.Type] = [SystemDestination.self]) {
        self.identifier = identifier
        self.category = category

        self.mainQueue = DispatchQueue(label: "com.sinoru.Logger." + (identifier ?? "main"), target: globalQueue)

        self.destinationTypes = destinationTypes

        type(of: self).loggers.updateValue(Weak(weakObject: self), forKey: ObjectIdentifier(self))
    }

    deinit {
        type(of: self).loggers.removeValue(forKey: ObjectIdentifier(self))
    }

    public func destination<T: LoggerDestination>(forType type: T.Type) -> T? {
        return self.destinations[ObjectIdentifier(type)] as? T
    }

    private func updateDestinations() {
        var destinations = [ObjectIdentifier:LoggerDestination]()

        (self.destinationTypes + type(of: self).globalDestinationTypes).forEach { destinationType in
            guard self.destinations[ObjectIdentifier(destinationType)] == nil else {
                return
            }

            let destination = destinationType.init(identifier: self.identifier, category: self.category)
            destinations[ObjectIdentifier(destinationType)] = destination
        }

        self.destinations = destinations
    }

    public func log(level: LogLevel, format: StaticString, _ args: CVarArg...) {
        for destination in self.destinations.values {
            self.mainQueue.async {
                destination.log(level: level, format: format, args)
            }
        }
    }

    public func debug(_ format: StaticString, _ args: CVarArg...) {
        self.log(level: .debug, format: format, args)
    }

    public func info(_ format: StaticString, _ args: CVarArg...) {
        self.log(level: .info, format: format, args)
    }

    public func warning(_ format: StaticString, _ args: CVarArg...) {
        self.log(level: .warning, format: format, args)
    }

    public func error(_ format: StaticString, _ args: CVarArg...) {
        self.log(level: .error, format: format, args)
    }

    public func fault(_ format: StaticString, _ args: CVarArg...) {
        self.log(level: .fault, format: format, args)
    }

}
