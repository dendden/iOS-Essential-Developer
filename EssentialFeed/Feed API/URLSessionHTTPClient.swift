//
//  URLSessionHTTPClient.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 17.05.2024.
//

import Foundation

public class URLSessionHTTPClient: HTTPClient {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error { }
    
    public func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        
        session.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
            }
            else if let data, let httpResponse = response as? HTTPURLResponse {
                completion(.success((data, httpResponse)))
            }
            else {
                completion(.failure(UnexpectedValuesRepresentation()))
            }
        }.resume()
    }
}
