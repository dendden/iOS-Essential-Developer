//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Denys Triasunov on 13.05.2024.
//

import XCTest

class URLSessionHTTPClient {
    
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func get(from url: URL) {
        session.dataTask(with: url) { _, _, _ in
            //
        }.resume()
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_resumesDataTaskWithURL() {
        
        let url = URL(string: "https://any-url.com")!
        let session = URLSessionSpy()
        let task = URLSessionDataTaskSpy()
        session.stub(url: url, withTask: task)
        let sut = URLSessionHTTPClient(session: session)
        
        sut.get(from: url)
        
        XCTAssertEqual(task.resumeCallsCount, 1)
    }
    
    // MARK: - Factory
    
    private class URLSessionSpy: URLSession {
        
        private var stubs = [URL: URLSessionDataTask]()
        
        func stub(url: URL, withTask task: URLSessionDataTask) {
            stubs[url] = task
        }
        
        override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
                        
            return stubs[url] ?? FakeURLSessionDataTask()
        }
    }
    
    private class FakeURLSessionDataTask: URLSessionDataTask {
        override func resume() {
            //
        }
    }
    
    private class URLSessionDataTaskSpy: URLSessionDataTask { 
        
        var resumeCallsCount: Int = 0
        
        override func resume() {
            resumeCallsCount += 1
        }
    }
}
