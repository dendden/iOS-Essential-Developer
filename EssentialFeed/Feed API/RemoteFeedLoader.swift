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
    
    public typealias FeedResult = LoadFeedResult<Error>
    
    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    
    public func load(completion: @escaping (FeedResult) -> Void) {
        client.get(from: url) { [weak self] result in
            
            // prevent completion execution after deallocation:
            guard self != nil else { return }
            
            switch result {
            case let .success((data, response)):
                completion(FeedItemsMapper.map(data: data, from: response))
            case .failure:
                completion(.failure(Error.connectivity))
            }
        }
    }
}
