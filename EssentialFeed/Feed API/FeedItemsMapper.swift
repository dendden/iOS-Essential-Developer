//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 12.05.2024.
//

import Foundation

internal final class FeedItemsMapper {
    
    private struct Root: Decodable {
        
        let items: [Item]
        
        var feedItems: [FeedItem] { items.map { $0.feedItem } }
    }

    private struct Item: Decodable {
        
        public let id: UUID
        public let description: String?
        public let location: String?
        public let image: URL
        
        var feedItem: FeedItem {
            FeedItem(id: id, description: description, location: location, imageURL: image)
        }
    }
    
    private static let OK_200: Int = 200
    
    internal static func map(data: Data, from response: HTTPURLResponse) -> RemoteFeedLoader.FeedResult {
        
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            return .failure(.invalidData)
        }
        
        return .success(root.feedItems)
    }
}
