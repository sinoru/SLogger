# SLogger
[![Build Status](https://travis-ci.org/sinoru/SwiftLogger.svg?branch=master)](https://travis-ci.org/sinoru/SwiftLogger)
[![codecov](https://codecov.io/gh/sinoru/SwiftLogger/branch/master/graph/badge.svg?token=ZRmyiCxKAB)](https://codecov.io/gh/sinoru/SwiftLogger)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/dc97e9d512b349309f0bb06f169a6c30)](https://www.codacy.com/app/sinoru/SwiftLogger?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=sinoru/SwiftLogger&amp;utm_campaign=Badge_Grade)

SLogger is a "swifty" lightweight, extensible logging framework.

### Usage

Using Swift Package Manager
If you want to use as xcodeproj, using `swift package generate-xcodeproj` command

### Requirements

- Swift 4
- Currently only works on Apple Platforms, will be work on Linux too.

### Examples

```Swift
// You can try with just:
Logger.debug("Test!")

// Or
let logger = Logger(identifier: "com.sinoru.Nemo", category: "photo")
logger.error("Loading photo error")

```

Additionaly You can create a class with LoggerDestination Protocol
And add it on globaly or just instance

### License ###

Read LICENSE for more information.
