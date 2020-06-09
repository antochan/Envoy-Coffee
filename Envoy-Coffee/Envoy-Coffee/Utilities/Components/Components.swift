//
//  Components.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

// MARK: - Component
public protocol Component {
    associatedtype ViewModel
    
    func apply(viewModel: ViewModel)
}

// MARK: - Reusable
public protocol Reusable {
    func prepareForReuse()
}

// MARK: - Actionable
public protocol Actionable {
    associatedtype Actions
    var actions: Actions? { get set }
}
