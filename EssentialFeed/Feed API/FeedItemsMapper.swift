//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 12.05.2024.
//

import Foundation

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
