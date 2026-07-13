//
//  FakeRefreshControl.swift
//  EssentialFeediOSTests
//
//  Created by Denys Triasunov on 13.07.2026.
//

import UIKit

class FakeRefreshControl: UIRefreshControl {
    
    private var _isRefreshing = false
    override var isRefreshing: Bool { _isRefreshing }
    
    override func beginRefreshing() {
        _isRefreshing = true
    }
    
    override func endRefreshing() {
        _isRefreshing = false
    }
}
