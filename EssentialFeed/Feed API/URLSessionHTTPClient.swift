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
    
    public func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        
        session.dataTask(with: url) { data, response, error in
            completion(Result {
                if let error {
                    throw error
                }
                else if let data, let httpResponse = response as? HTTPURLResponse {
                    return (data, httpResponse)
                }
                else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }.resume()
    }
}
