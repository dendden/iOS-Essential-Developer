//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Denys Triasunov on 03.07.2024.
//

import Foundation

func anyURL() -> URL { URL(string: "https://any-url.com")! }

func anyNSError() -> NSError { NSError(domain: "any error", code: 1) }
