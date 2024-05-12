//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 05.05.2024.
//

import Foundation

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
                completion(FeedItemsMapper.map(data: data, from: response))
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
