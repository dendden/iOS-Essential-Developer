//
//  XCTestCase+URL.swift
//  EssentialFeedTests
//
//  Created by Denys Triasunov on 02.06.2024.
//

import XCTest

extension XCTestCase {
    
    func anyURL() -> URL { URL(string: "https://any-url.com")! }
    func anyNSError() -> NSError { NSError(domain: "any error", code: 1) }
}
