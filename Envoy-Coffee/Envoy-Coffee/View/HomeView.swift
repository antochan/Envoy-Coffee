//
//  HomeView.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/7.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
}

//MARK: - Private
private extension HomeView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        
    }
    
    func configureLayout() {
        
    }
}
