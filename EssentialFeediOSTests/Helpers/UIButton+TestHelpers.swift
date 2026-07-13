//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Denys Triasunov on 13.07.2026.
//

import UIKit

extension UIButton {
    
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
