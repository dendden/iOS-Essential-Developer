//
//  UIControl+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Denys Triasunov on 13.07.2026.
//

import UIKit

extension UIControl {
    
    func simulate(event: UIControl.Event) {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: event)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
