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
    private let filterConfigurations: FilterConfigurations
    
    override func loadView() {
        super.loadView()
        view = filterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonActions()
        filterView.applyInitialFilterView(filterConfigs: filterConfigurations)
    }
    
    init(filterConfigs: FilterConfigurations) {
        self.filterConfigurations = filterConfigs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupButtonActions() {
        filterView.cancelButton.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.dismiss(animated: true)
        }
        
        filterView.distanceSlider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        filterView.distanceSliderLabel.text = "\(sender.value.rounded()) meters"
    }
}
