//
//  HomeViewController.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/7.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let homeView = HomeView()
    
    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}
