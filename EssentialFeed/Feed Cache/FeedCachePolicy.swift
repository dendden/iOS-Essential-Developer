//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 09.07.2024.
//

import Foundation

internal final class FeedCachePolicy {
    
    private static let calendar = Calendar(identifier: .gregorian)
    private static let maxCacheAgeInDays: Int = 7
    
    private init() { }
    
    internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
        
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp)
        else { return false }
        return date < maxCacheAge
    }
}
