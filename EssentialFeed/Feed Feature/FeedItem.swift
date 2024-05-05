//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 05.05.2024.
//

import Foundation

struct FeedItem: Codable {
    
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
