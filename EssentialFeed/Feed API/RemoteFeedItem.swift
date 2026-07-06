//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 16.06.2024.
//

import Foundation

struct RemoteFeedItem: Decodable {
    
    let id: UUID
    let description: String?
    let location: String?
    let image: URL
}
