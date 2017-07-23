//
//  LoggerTests.swift
//  SLoggerTests
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

import XCTest
@testable import SLogger

class LoggerTests: XCTestCase {

    func testDebug() {
        Logger.debug("Test")
    }

    func testInfo() {
        Logger.info("Test")
    }

    static var allTests: [(String, (LoggerTests) -> () throws -> Void)] {
        return [
            ("testDebug", testDebug),
            ("testInfo", testInfo)
        ]
    }

}
