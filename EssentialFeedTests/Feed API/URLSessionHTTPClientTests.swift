//
//  URLSessionHTTPClientTests.swift
//  EssentialFeedTests
//
//  Created by Denys Triasunov on 13.05.2024.
//

import EssentialFeed
import XCTest

protocol HTTPSession {
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> HTTPSessionTask
}

protocol HTTPSessionTask {
    
    func resume()
}

class URLSessionHTTPClient {
    
    private let session: HTTPSession
    
    init(session: HTTPSession) {
        self.session = session
    }
    
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
        session.dataTask(with: url) { _, _, error in
            if let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

final class URLSessionHTTPClientTests: XCTestCase {
    
    func test_getFromURL_resumesDataTaskWithURL() {
        
        let url = URL(string: "https://any-url.com")!
        let session = HTTPSessionSpy()
        let task = HTTPSessionTaskSpy()
        session.stub(url: url, withTask: task)
        let sut = URLSessionHTTPClient(session: session)
        
        sut.get(from: url) { _ in }
        
        XCTAssertEqual(task.resumeCallsCount, 1)
    }
    
    func test_getFromURL_failsOnRequestError() {
        
        let url = URL(string: "https://any-url.com")!
        let session = HTTPSessionSpy()
        let error = NSError(domain: "any error", code: 1)
        session.stub(url: url, withError: error)
        let sut = URLSessionHTTPClient(session: session)
        
        let exp = expectation(description: "Wait for completion")
        
        sut.get(from: url) { result in
            switch result {
            case .failure(let receivedError as NSError):
                XCTAssertEqual(error, receivedError)
            default:
                XCTFail("Expected failure with \(error), got \(result) instead")
            }
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1.0)
    }
    
    // MARK: - Factory
    
    private class HTTPSessionSpy: HTTPSession {
        
        private struct Stub {
            let task: HTTPSessionTask
            let error: Error?
        }
        
        private var stubs = [URL: Stub]()
        
        func stub(url: URL, withTask task: HTTPSessionTask = FakeHTTPSessionTask(), withError error: Error? = nil) {
            stubs[url] = Stub(task: task, error: error)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> HTTPSessionTask {
            
            guard let stub = stubs[url] else {
                fatalError("Unable to find stub for \(url)")
            }
                 
            completionHandler(nil, nil, stub.error)
            return stub.task
        }
    }
    
    private class FakeHTTPSessionTask: HTTPSessionTask {
        func resume() {
            //
        }
    }
    
    private class HTTPSessionTaskSpy: HTTPSessionTask {
        
        var resumeCallsCount: Int = 0
        
        func resume() {
            resumeCallsCount += 1
        }
    }
}
