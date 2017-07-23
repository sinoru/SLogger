# Logger
[![Build Status](https://travis-ci.com/sinoru/SwiftLogger.svg?token=HQx9vttn6bQ5EcFzbrJz&branch=master)](https://travis-ci.org/sinoru/SwiftLogger)

Logger is a "swifty" logging utility for Swift.

### Usage

Using Swift Package Manager
If you want to use as xcodeproj, using `swift package generate-xcodeproj` command

### Requirements

- Swift 4
- Currently only works on Apple Platform, will be work on Linux too.

### Examples

```Swift
// You can try with just:
Logger.debug("Test!")
// Or
let logger = Logger(identifier: "com.sinoru.Nemo", category: "photo")
logger.error("Loading photo error")


// Additionaly You can create a class with LoggerDestination Protocol and add it on globaly or just instance

```

### License ###

Read LICENSE for more information.
