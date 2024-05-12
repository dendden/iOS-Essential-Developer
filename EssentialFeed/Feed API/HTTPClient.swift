//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 12.05.2024.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
        
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
