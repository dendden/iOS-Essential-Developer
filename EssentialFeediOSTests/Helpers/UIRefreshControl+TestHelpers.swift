//
//  UIRefreshControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Denys Triasunov on 13.07.2026.
//

import UIKit

extension UIRefreshControl {
    
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
