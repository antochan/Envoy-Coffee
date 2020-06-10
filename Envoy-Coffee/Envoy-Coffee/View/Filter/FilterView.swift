//
//  FilterView.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/9.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class FilterView: UIView {
    let cancelButton: CircularImageButton = {
        let cancelButton = CircularImageButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        let cancelVM = CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "cancel"))
        cancelButton.apply(viewModel: cancelVM)
        cancelButton.alpha = 0
        return cancelButton
    }()
    
    let mainContentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let filterTitleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    private let filterTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.mainBold(size: 28)
        label.text = "Envoy Coffee Filters"
        label.numberOfLines = 1
        return label
    }()
    
    private let filterSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.mainBold(size: 14)
        label.textColor = .lightGray
        label.text = "Apply your filters here and explore more around the Envoy Office! :)"
        label.numberOfLines = 0
        return label
    }()
    
    let filterStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.sixteen
        return stackView
    }()
    
    private let distanceSliderTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.mainBold(size: 15)
        label.text = "Distance in meters"
        label.numberOfLines = 1
        return label
    }()
    
    let distanceSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 200
        slider.maximumValue = 1500
        slider.tintColor = .black
        return slider
    }()
    
    let distanceSliderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.main(size: 12)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let sectionCategoryTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.mainBold(size: 15)
        label.text = "Filter categories by:"
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func applyInitialFilterView(filterConfigs: FilterConfigurations) {
        distanceSlider.value = Float(filterConfigs.radius ?? 200)
        distanceSliderLabel.text = "\(filterConfigs.radius ?? 200) meters"
    }
    
    
}

//MARK: Private
private extension FilterView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(mainContentScrollView, cancelButton)
        mainContentScrollView.addSubviews(filterTitleStack, filterStack)
        filterTitleStack.addArrangedSubviews([filterTitleLabel, filterSubtitleLabel])
        filterStack.addArrangedSubviews([distanceSliderTitleLabel, distanceSlider, distanceSliderLabel, sectionCategoryTitleLabel])
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            mainContentScrollView.topAnchor.constraint(equalTo: topAnchor),
            mainContentScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContentScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContentScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainContentScrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.thirtyTwo),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            
            filterTitleStack.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: Spacing.sixteen),
            filterTitleStack.centerXAnchor.constraint(equalTo: mainContentScrollView.centerXAnchor),
            filterTitleStack.widthAnchor.constraint(equalTo: mainContentScrollView.widthAnchor, multiplier: 0.9),
            
            filterStack.topAnchor.constraint(equalTo: filterTitleStack.bottomAnchor, constant: Spacing.fortyEight),
            filterStack.widthAnchor.constraint(equalTo: mainContentScrollView.widthAnchor, multiplier: 0.8),
            filterStack.centerXAnchor.constraint(equalTo: mainContentScrollView.centerXAnchor),
        ])
    }
}
