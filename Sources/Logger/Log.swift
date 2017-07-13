//
//  Log.swift
//  Log
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

public struct Log {
    public static func debug(logger: Logger = Logger.shared, _ format: StaticString,_ args: CVarArg...) {
        logger.debug(format, args)
    }

    public static func info(logger: Logger = Logger.shared, _ format: StaticString,_ args: CVarArg...) {
        logger.info(format, args)
    }
}
