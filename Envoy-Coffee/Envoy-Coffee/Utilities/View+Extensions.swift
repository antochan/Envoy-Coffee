//
//  View+Extensions.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func fadeOut(duration: TimeInterval = 0.1, delay: TimeInterval = 0) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0
        }, completion: { finished in
            self.isHidden = true
        })
    }
    
    func fadeIn(duration: TimeInterval = 0.1, delay: TimeInterval = 0) {
        isHidden = false
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 1
        }, completion: { finished in
            self.isHidden = false
        })
    }
}

extension UIStackView {
    func addArrangedSubviews(_ arrangedViews: [UIView]) {
        arrangedViews.forEach { addArrangedSubview($0) }
    }
}

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Int{
   func rounding(nearest: Int) -> Int {
        return nearest * Int(round(Float(self) / Float(nearest)))
    }
}
