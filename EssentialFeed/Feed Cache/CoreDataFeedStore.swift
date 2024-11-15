//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Denys Triasunov on 14.11.2024.
//

import CoreData

public final class CoreDataFeedStore: FeedStore {
    
//    private let container: NSPersistentContainer
//    private let context: NSManagedObjectContext
//    
//    public init(storeURL: URL, bundle: Bundle = .main) throws {
//        container = try NSPersistentContainer.load()
//        context = container.newBackgroundContext()
//    }
    
    public init() { }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        
    }
}
