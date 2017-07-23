//
//  LogTests.swift
//  LoggerTests
//
//  Created by Sinoru on 2017. 7. 23..
//

import XCTest
@testable import Logger

class LogTests: XCTestCase {
    func testDebug() {
        Log.debug("Test")
    }

    func testInfo() {
        Log.info("Test")
    }

    static var allTests: [(String, (LogTests) -> () throws -> Void)] {
        return [
            ("testDebug", testDebug),
            ("testInfo", testInfo)
        ]
    }
}
