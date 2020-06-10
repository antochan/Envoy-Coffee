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
    private var filterConfigurations: FilterConfigurations {
        didSet {
            filterView.applyFilterView(filterConfigs: filterConfigurations)
        }
    }
    
    private enum SectionConstants: String {
        case coffee = "coffee"
        case food = "food"
        case shops = "shops"
        case arts = "arts"
    }
    
    override func loadView() {
        super.loadView()
        view = filterView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonActions()
        filterView.applyFilterView(filterConfigs: filterConfigurations)
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
        
        /// Distance Filter
        filterView.distanceSlider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
        
        /// Section Filters
        filterView.coffeeSection.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.filterConfigurations.sectionQuery = SectionConstants.coffee.rawValue
        }
        
        filterView.foodSectionButton.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.filterConfigurations.sectionQuery = SectionConstants.food.rawValue
        }
        
        filterView.shopsSectionButton.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.filterConfigurations.sectionQuery = SectionConstants.shops.rawValue
        }
        
        filterView.artsSectionButton.actions = { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.filterConfigurations.sectionQuery = SectionConstants.arts.rawValue
        }
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        filterConfigurations.radius = Int(sender.value.rounded())
    }
}
