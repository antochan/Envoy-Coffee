//
//  FilterViewController.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/9.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    let filterView = FilterView()
    
    override func loadView() {
        super.loadView()
        view = filterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
