//
//  FilterViewController.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/9.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

protocol FilterDelegate: AnyObject {
    func applyNewFilter(filterConfigs: FilterConfigurations)
}

class FilterViewController: UIViewController {
    let filterView = FilterView()
    weak var delegate: FilterDelegate?
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
        
        /// Debug Clients
        filterView.clientIdTextField.delegate = self
        filterView.clientSecretTextField.delegate = self
        
        /// Submit Filter Buttons
        filterView.applyFilterButton.addTarget(self, action: #selector(applyNewFilters), for: .touchUpInside)
        filterView.resetToDefaultButton.addTarget(self, action: #selector(resetFilters), for: .touchUpInside)
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!) {
        filterConfigurations.radius = Int(sender.value.rounded())
    }
    
    @objc func applyNewFilters() {
        delegate?.applyNewFilter(filterConfigs: filterConfigurations)
        dismiss(animated: true)
    }
    
    @objc func resetFilters() {
        delegate?.applyNewFilter(filterConfigs: FilterConfigurations.defaultFilterConfiguration)
        dismiss(animated: true)
    }
}

//MARK: - UITextFieldDelegate
extension FilterViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case FilterTextfieldTags.clientID.rawValue:
            guard let clientId = textField.text else {
                filterConfigurations.clientID = AppConstants.clientId
                return
            }
            if clientId == "" {
                filterConfigurations.clientID = AppConstants.clientId
            } else {
                filterConfigurations.clientID = clientId
            }
        case FilterTextfieldTags.clientSecret.rawValue:
            guard let clientSecret = textField.text else {
                filterConfigurations.clientSecret = AppConstants.clientSecret
                return
            }
            if clientSecret == "" {
                filterConfigurations.clientSecret = AppConstants.clientSecret
            } else {
                filterConfigurations.clientSecret = clientSecret
            }
        default:
            break
        }
    }
}
