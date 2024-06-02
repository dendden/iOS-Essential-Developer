//
//  CacheFeedUseCaseTests.swift
//  EssentialFeedTests
//
//  Created by Denys Triasunov on 02.06.2024.
//

import XCTest

class LocalFeedLoader {
    
    private let store: FeedStore
    
    init(store: FeedStore) {
        self.store = store
    }
}

class FeedStore {
    
    var deleteCachedFeedCallCount: Int = 0
}

class CacheFeedUseCaseTests: XCTestCase {
    
    func test_init_doesNotDeleteCacheUponCreation() {
        
        let store = FeedStore()
        _ = LocalFeedLoader(store: store)
        
        XCTAssertEqual(store.deleteCachedFeedCallCount, 0)
    }
}
