//
//  FeedCacheTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Denys Triasunov on 02.06.2024.
//

import EssentialFeed
import Foundation
import XCTest

func uniqueImage() -> FeedImage {
    FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
}

func uniqueImagesFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
    let models = [uniqueImage(), uniqueImage()]
    let local = models.map {
        LocalFeedImage(id: $0.id,
                       description: $0.description,
                       location: $0.location,
                       url: $0.url)
    }
    return (models, local)
}

extension Date {
    
    private var feedCacheMaxAgeInDays: Int { 7 }
    
    func minusFeedCacheMaxAge() -> Date {
        adding(days: -feedCacheMaxAgeInDays)
    }
    
    func adding(days: Int) -> Date {
        Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }
    
    func adding(seconds: TimeInterval) -> Date {
        self + seconds
    }
}
