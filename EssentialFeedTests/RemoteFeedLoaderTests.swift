//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Denys Triasunov on 05.05.2024.
//

import XCTest

class RemoteFeedLoader {
    
}

class HTTPClient {
    
    var requestedURL: URL?
}

class RemoteFeedLoaderTests: XCTestCase {
    
    func test_init_doesNotRequestDataFromURL() {
        
        let client = HTTPClient()
        _ = RemoteFeedLoader()
        
        XCTAssertNil(client.requestedURL)
    }
}
