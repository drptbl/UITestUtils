//
//  XCTestCase+Screenshots.swift
//
//  Copyright (c) 2015 Andrey Fidrya
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import XCTest

extension XCTestCase {
    public func saveScreenshot(filename: String, createDirectory: Bool = true) {
        if createDirectory {
            let directory = (filename as NSString).stringByDeletingLastPathComponent
            let fileManager = NSFileManager.defaultManager()
            if !fileManager.fileExistsAtPath(directory) {
                do {
                    try fileManager.createDirectoryAtPath(directory, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    // Ignore
                }
            }
        }

        let data = dataFromRemoteEndpoint("screenshot.png")
        guard let imageData = data else {
            XCTFail("No data received (UITestServer not running?)")
            return
        }
        if imageData.length == 0 {
            XCTFail("Empty screenshot received")
            return
        }
        if !imageData.writeToFile(filename, atomically: false) {
            XCTFail("Unable to save the screenshot: \(filename)")
        }
        print("Screenshot saved: \(filename)")
    }
}
