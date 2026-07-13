//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Denys Triasunov on 13.07.2026.
//

import Foundation

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
