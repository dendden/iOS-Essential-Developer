//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 12.05.2024.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}

internal final class FeedItemsMapper {
    
    private struct Root: Decodable {
        
        let items: [RemoteFeedItem]
    }
    
    private static let OK_200: Int = 200
    
    internal static func map(data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem] {
        
        guard response.statusCode == OK_200,
              let root = try? JSONDecoder().decode(Root.self, from: data)
        else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        return root.items
    }
}
