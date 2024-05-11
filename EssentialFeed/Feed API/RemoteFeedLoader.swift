//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 05.05.2024.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
        
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public final class RemoteFeedLoader {
    
    private let url: URL
    private let client: HTTPClient
    
    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }
    
    public typealias FeedResult = Result<[FeedItem], RemoteFeedLoader.Error>
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (FeedResult) -> Void) {
        client.get(from: url) { result in
            
            switch result {
            case let .success((data, response)):
                if let items = try? FeedItemsMapper.map(data, response) {
                    
                    completion(.success(items))
                }
                else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

private class FeedItemsMapper {
    
    private struct Root: Decodable {
        let items: [Item]
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
    
    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> [FeedItem] {
        
        guard response.statusCode == 200 else {
            throw RemoteFeedLoader.Error.invalidData
        }
        
        let root = try JSONDecoder().decode(Root.self, from: data)
        return root.items.map { $0.feedItem }
    }
}
